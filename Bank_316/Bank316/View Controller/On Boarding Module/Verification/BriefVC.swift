//
//  BriefVC.swift
//  Bank 316
//
//  Created by Dhairya on 25/09/23.
//

import UIKit
import AVFoundation

class BriefVC: UIViewController {
    
    @IBOutlet weak var letsGoButton: UIButton!
    @IBOutlet weak var sessionLabel: UILabel!
    @IBOutlet weak var permissionView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad() 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        permissionView.setRoundedManualTopCorners(cornerRadius: 20.0)
    }
    //MARK: - Private func to update UI
    private func updateUI(permission: Bool = false){
        if permission == true{
            self.sessionLabel.isHidden = true
            self.letsGoButton.isHidden = true
            self.permissionView.isHidden = false
        }else{
            self.permissionView.isHidden = true
            self.sessionLabel.isHidden = false
            self.letsGoButton.isHidden = false
        }
    }
    
    //MARK: - Action Events
    @IBAction func cancelButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func letsGoButton(_ sender: UIButton) {
        updateUI(permission: true)
        proceedWithCameraAccess()
    }
    
    func proceedWithCameraAccess(){
        // handler in .requestAccess is needed to process user's answer to our request
        AVCaptureDevice.requestAccess(for: .video) { success in
            if success { // if request is granted (success is true)
                DispatchQueue.main.async {
                    let vc: IdVerificationVC = IdVerificationVC.instantiateViewController(identifier: .verification)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            } else { // if request is denied (success is false)
                // Create Alert
                let alert = UIAlertController(title: "Camera", message: "Camera access is absolutely necessary to use this app", preferredStyle: .alert)
                // Add "OK" Button to alert, pressing it will bring you to the settings app
                DispatchQueue.main.async {
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                    }))
                    // Show the alert with animation
                    self.present(alert, animated: true)
                }
            }
        }
    }
}
