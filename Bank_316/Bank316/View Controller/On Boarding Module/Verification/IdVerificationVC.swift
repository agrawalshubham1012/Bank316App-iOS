//
//  IdVerificationVC.swift
//  Bank 316
//
//  Created by Dhairya on 25/09/23.
//

import UIKit
import AVFoundation

class IdVerificationVC: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var camerabutton: UIButton!
    @IBOutlet weak var cameraImage: UIImageView!
    @IBOutlet weak var photoClickView: UIView!
    @IBOutlet weak var retakeNextView: UIView!
    
    let captureSession = AVCaptureSession()
    let stillImageOutput = AVCaptureStillImageOutput()
    var previewLayer : AVCaptureVideoPreviewLayer?
    var captureDevice : AVCaptureDevice?
    var isFromCompleteProfile:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openCamera()
    }
    
    
    func openCamera(){
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
    
    //MARK: - Action Events
    @IBAction func cameraButton(_ sender: UIButton) {
        openCamera()
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func retakeButton(_ sender: UIButton) {
        openCamera()
    }
    
    
    @IBAction func nextButton(_ sender: UIButton) {
        idVerification()
    }
    
    
    private func idVerification(){
        startAnimation(view: self.view)
        guard let image = self.cameraImage.image else { return }
        APIDataManager.shared.uploadGovtId(image: image, params:[:]) { result in
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
            let vc: InstructionVC = InstructionVC.instantiateViewController(identifier: .verification)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension IdVerificationVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        cameraImage.image = image
        self.photoClickView.isHidden = true
        self.retakeNextView.isHidden = false
        print(image.size)
    }
}
