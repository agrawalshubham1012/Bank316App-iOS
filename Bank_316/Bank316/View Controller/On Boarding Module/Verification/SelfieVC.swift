//
//  SelfieVC.swift
//  Bank 316
//
//  Created by Dhairya on 25/09/23.
//

import UIKit
import AVFoundation
import Vision

class SelfieVC: UIViewController {
    
    @IBOutlet weak var faceImageView: UIImageView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var selfieView: FaceView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var retakeNextView: UIView!
    
    var sequenceHandler = VNSequenceRequestHandler()
    var captureImage: Bool?
    let session = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer!
    var faceImage: UIImage!
    var imageRect = CGRect()
    let dataOutputQueue = DispatchQueue (
        label: "video data queue",
        qos: .userInitiated,
        attributes: [],
        autoreleaseFrequency: .workItem)
    var faceViewHidden = false
    var maxX: CGFloat = 0.0
    var midY: CGFloat = 0.0
    var maxY: CGFloat = 0.0
    var isFromCompleteProfile:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI(){
        self.retakeNextView.isHidden = true
        captureImage = false
        configureCaptureSession()
        cameraButton.isHidden = false
        faceImageView.isHidden = true
        maxX = bgView.bounds.maxX
        midY = bgView.bounds.midY
        maxY = bgView.bounds.maxY
        DispatchQueue.global(qos: .background).async {
            self.session.startRunning()
        }
    }
    
    override func didReceiveMemoryWarning() {
        URLCache.shared.removeAllCachedResponses()
        URLCache.shared.diskCapacity = 0
        URLCache.shared.memoryCapacity = 0
    }
    
    //MARK: - Private function to upload selfie
    
    func imageFromSampleBuffer(sampleBuffer : CMSampleBuffer) -> UIImage{
        // Get a CMSampleBuffer's Core Video image buffer for the media data
        let  imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
        // Lock the base address of the pixel buffer
        CVPixelBufferLockBaseAddress(imageBuffer!, CVPixelBufferLockFlags.readOnly);
        // Get the number of bytes per row for the pixel buffer
        let baseAddress = CVPixelBufferGetBaseAddress(imageBuffer!);
        // Get the number of bytes per row for the pixel buffer
        let bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer!);
        // Get the pixel buffer width and height
        let width = CVPixelBufferGetWidth(imageBuffer!);
        let height = CVPixelBufferGetHeight(imageBuffer!);
        
        // Create a device-dependent RGB color space
        let colorSpace = CGColorSpaceCreateDeviceRGB();
        
        // Create a bitmap graphics context with the sample buffer data
        var bitmapInfo: UInt32 = CGBitmapInfo.byteOrder32Little.rawValue
        bitmapInfo |= CGImageAlphaInfo.premultipliedFirst.rawValue & CGBitmapInfo.alphaInfoMask.rawValue
        //let bitmapInfo: UInt32 = CGBitmapInfo.alphaInfoMask.rawValue
        let context = CGContext.init(data: baseAddress, width: width, height: height, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo)
        // Create a Quartz image from the pixel data in the bitmap graphics context
        let quartzImage = context?.makeImage();
        // Unlock the pixel buffer
        CVPixelBufferUnlockBaseAddress(imageBuffer!, CVPixelBufferLockFlags.readOnly);
        // Create an image object from the Quartz image
        let image = UIImage.init(cgImage: quartzImage!);
        return (image);
    }
    
    
    //MARK: - Action events
    @IBAction func cameraButton(_ sender: Any) {
        captureImage = true
        cameraButton.isHidden = true
        faceImageView.isHidden = false
        faceImageView.image = faceImage
        bgView.isHidden = true
        self.retakeNextView.isHidden = false
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        faceImage = nil
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func retakeButton(_ sender: UIButton) {
        retakeAction()
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        photoVerification()
    }
    

}


//Call APIs
extension SelfieVC {
    
    private func photoVerification(){
        startAnimation(view: self.view)
        guard let image = self.faceImageView.image else { return }
        APIDataManager.shared.uploadUserPhoto(image: image, params:[:]) { result in
            switch result{
            case .success(let data):
                defer{
                    stopAnimation(view: self.view)
                }
                print(data)
                if data.status ?? false {
                    self.finalVerfication()
                }
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    
    private func finalVerfication(){
        startAnimation(view: self.view)
        APIDataManager.shared.finalDocVerification() { result in
            switch result{
            case .success(let data):
                defer{
                    stopAnimation(view: self.view)
                }
                print(data)
                if data.status ?? false {
                    self.navigateToNextVC()
                }
            case .failure(let error):
                print(error)
                
            }
        }
    }

    
    func navigateToNextVC(){
        if isFromCompleteProfile {
            let vc: CompleteVerificationVC = CompleteVerificationVC.instantiateViewController(identifier: .verification)
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc: CompleteVerificationVC = CompleteVerificationVC.instantiateViewController(identifier: .verification)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func retakeAction(){
        self.retakeNextView.isHidden = true
        bgView.isHidden = false
        captureImage = false
        cameraButton.isHidden = false
        faceImageView.isHidden = true
        maxX = bgView.bounds.maxX
        midY = bgView.bounds.midY
        maxY = bgView.bounds.maxY
    }

    
}



// MARK: - Video Processing methods

extension SelfieVC {
    func configureCaptureSession() {
        // Define the capture device we want to use
        guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                   for: .video,
                                                   position: .front) else {
            fatalError("No front video camera available")
        }
        
        // Connect the camera to the capture session input
        do {
            let cameraInput = try AVCaptureDeviceInput(device: camera)
            session.addInput(cameraInput)
        } catch {
            fatalError(error.localizedDescription)
        }
        
        // Create the video data output
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: dataOutputQueue)
        videoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA]
        
        // Add the video output to the capture session
        session.addOutput(videoOutput)
        
        let videoConnection = videoOutput.connection(with: .video)
        videoConnection?.videoOrientation = .portrait
        
        // Configure the preview layer
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = UIScreen.main.bounds
        bgView.layer.insertSublayer(previewLayer, at: 0)
    }
}

// MARK: - AVCaptureVideoDataOutputSampleBufferDelegate methods

extension SelfieVC: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        // 1
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        
        // 2
        let detectFaceRequest = VNDetectFaceLandmarksRequest(completionHandler: detectedFace)
        
        // 3
        do {
            try sequenceHandler.perform(
                [detectFaceRequest],
                on: imageBuffer,
                orientation: .leftMirrored)
        } catch {
            print(error.localizedDescription)
        }
        //
        if captureImage == true {
            DispatchQueue.main.async {
                let sampleImg = self.imageFromSampleBuffer(sampleBuffer: sampleBuffer)
                self.faceImage = sampleImg
                self.faceImageView.image = sampleImg
                self.captureImage = false
                self.retakeNextView.isHidden = false
            }
        }
    }
    
}

extension SelfieVC {
    func convert(rect: CGRect) -> CGRect {
        // 1
        let origin = previewLayer.layerPointConverted(fromCaptureDevicePoint: rect.origin)
        
        // 2
        let size = previewLayer.layerPointConverted(fromCaptureDevicePoint: rect.size.cgPoint)
        
        // 3
        return CGRect(origin: origin, size: size.cgSize)
    }
    
    // 1
    func landmark(point: CGPoint, to rect: CGRect) -> CGPoint {
        // 2
        let absolute = point.absolutePoint(in: rect)
        
        // 3
        let converted = previewLayer.layerPointConverted(fromCaptureDevicePoint: absolute)
        
        // 4
        return converted
    }
    
    func landmark(points: [CGPoint]?, to rect: CGRect) -> [CGPoint]? {
        guard let points = points else {
            return nil
        }
        
        return points.compactMap { landmark(point: $0, to: rect) }
    }
    
    func updateFaceView(for result: VNFaceObservation) {
        defer {
            DispatchQueue.main.async {
                self.selfieView.setNeedsDisplay()
            }
        }
        
        let box = result.boundingBox
        
        selfieView.boundingBox = convert(rect: box)
        if captureImage == true {
            imageRect = convert(rect: box)
        }
        guard let landmarks = result.landmarks else {
            return
        }
        
        if let leftEye = landmark(
            points: landmarks.leftEye?.normalizedPoints,
            to: result.boundingBox) {
            selfieView.leftEye = leftEye
        }
        
        if let rightEye = landmark(
            points: landmarks.rightEye?.normalizedPoints,
            to: result.boundingBox) {
            selfieView.rightEye = rightEye
        }
        
        if let leftEyebrow = landmark(
            points: landmarks.leftEyebrow?.normalizedPoints,
            to: result.boundingBox) {
            selfieView.leftEyebrow = leftEyebrow
        }
        
        if let rightEyebrow = landmark(
            points: landmarks.rightEyebrow?.normalizedPoints,
            to: result.boundingBox) {
            selfieView.rightEyebrow = rightEyebrow
        }
        
        if let nose = landmark(
            points: landmarks.nose?.normalizedPoints,
            to: result.boundingBox) {
            selfieView.nose = nose
        }
        
        if let outerLips = landmark(
            points: landmarks.outerLips?.normalizedPoints,
            to: result.boundingBox) {
            selfieView.outerLips = outerLips
        }
        
        if let innerLips = landmark(
            points: landmarks.innerLips?.normalizedPoints,
            to: result.boundingBox) {
            selfieView.innerLips = innerLips
        }
        
        if let faceContour = landmark(
            points: landmarks.faceContour?.normalizedPoints,
            to: result.boundingBox) {
            selfieView.faceContour = faceContour
        }
    }
    
    
    func detectedFace(request: VNRequest, error: Error?) {
        guard
            let results = request.results as? [VNFaceObservation],
            let result = results.first
        else {
            selfieView.clear()
            if captureImage == true {
                DispatchQueue.main.async {
                    DispatchQueue.main.async {
                        self.faceImageView.isHidden = true
                        self.retakeNextView.isHidden = true
                    }
                    self.cameraButton.isHidden = false
                    let alert = UIAlertController(title: "No Face!", message: "No face was detected", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { [self] _ in
                        retakeAction()
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            }
            return
        }
        
        if faceViewHidden {
            
        } else {
            updateFaceView(for: result)
        }
    }
    
}
extension CGPoint {
    func scaled(to size: CGSize) -> CGPoint {
        return CGPoint(x: self.x * size.width,
                       y: self.y * size.height)
    }
}
