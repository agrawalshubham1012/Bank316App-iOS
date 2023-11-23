//
//  forgotPasswordVC.swift
//  Bank 316
//
//  Created by Dhairya on 30/08/23.
//

import UIKit

class forgotPasswordVC: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    private var emailValidation = ValidateEmailPassword()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSwipeNavigation()
    }
    
    private func setSwipeNavigation(){
        // Add a swipe gesture recognizer for left swipes
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        leftSwipeGesture.direction = .left
        view.addGestureRecognizer(leftSwipeGesture)
        
        // Add a swipe gesture recognizer for right swipes
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        rightSwipeGesture.direction = .right
        view.addGestureRecognizer(rightSwipeGesture)
    }
    
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            print("")
        } else if gesture.direction == .right {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //MARK: -  Private func for validations
    private func continueButtonStatusChange(buttonTitleColor: UIColor, buttonBackgroundColor: UIColor){
        self.submitButton.titleLabel?.textColor = buttonTitleColor
        self.submitButton.setTitleColor(buttonTitleColor, for: .normal)
        self.submitButton.backgroundColor = buttonBackgroundColor
    }
    
    //Email ID Validation
    private func validateEmail(){
        if emailValidation.validateEmail(textField: emailTF, buttonStatus: self.submitButton){
            self.continueButtonStatusChange(buttonTitleColor: UIColor(red: 0.09, green: 0.20, blue: 0.00, alpha: 1.00), buttonBackgroundColor: UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00))
            self.submitButton.isEnabled = true
            
        }else{
            self.continueButtonStatusChange(buttonTitleColor: UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.6), buttonBackgroundColor: UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.2))
            self.submitButton.isEnabled = false
        }
    }
    //MARK: - Action Events
    
    @IBAction func privacyPolicyButton(_ sender: UIButton) {
        
    }
    
    @IBAction func emailTF(_ sender: UITextField) {
        validateEmail()
    }
    
    @IBAction func submitButton(_ sender: UIButton) {
        if let email = emailTF.text{
            forgotPasswordApi(email: email)
        }
    }
}

//MARK: - API Calls
extension forgotPasswordVC {
    private func forgotPasswordApi(email: String){
        startAnimation(view: self.view)
        let parameters = [ "email": email ]
        ForgotPasswordDataManager.shared.forgotPasswordManager(params: parameters) {
            result in
            switch result{
            case .success(let data):
                print(data)
                defer{
                    stopAnimation(view: self.view)
                }
                if data.status == true{
                    
                    let vc: OtpVC = OtpVC.instantiateViewController(identifier: .login)
                    vc.identifier = "forgot Password"
                    vc.emailID = email
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    print("False")
                }
                print(data)
            case .failure(let error):
                defer{
                    stopAnimation(view: self.view)
                }
                print(error)
            }
        }
    }
}
