//
//  CreatePasswordVC.swift
//  Bank 316
//
//  Created by Dhairya on 24/08/23.
//

import UIKit

class CreatePasswordVC: UIViewController {
    
    @IBOutlet weak var warningView: UIView!
    @IBOutlet weak var rememberMeButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var newPasswordButton: UIButton!
    @IBOutlet weak var confirmPasswordTF: StopPasteAction!
    @IBOutlet weak var newPasswordTF: StopPasteAction!
    @IBOutlet weak var confirmPasswordButton: UIButton!
    @IBOutlet weak var showPassword: UIButton!
    @IBOutlet weak var privacyPolicyButton: UIButton!
    
    var rememberMe = true
    private var passwordValidator = ValidateEmailPassword()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - Private functions
    private func passwordHideShow(showPassTitle: String, secureTextEntry: Bool) {
        newPasswordTF.isSecureTextEntry = secureTextEntry
        confirmPasswordTF.isSecureTextEntry = secureTextEntry
        showPassword.setTitle(showPassTitle, for: .normal)
    }
    
    private func continueButtonStatusChange(buttonTitleColor: UIColor, buttonBackgroundColor: UIColor, userInteraction: Bool){
        self.continueButton.titleLabel?.textColor = buttonTitleColor
        self.continueButton.setTitleColor(buttonTitleColor, for: .normal)
        self.continueButton.backgroundColor = buttonBackgroundColor
        self.continueButton.isUserInteractionEnabled = userInteraction
    }

    //MARK: - PASSWORD VALIDATION WITH REJEX METHODOLOGY
    private func validpassword(mypassword : String) -> Bool{
            let passwordreg =  ("(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z])(?=.*[@#$%^&*]).{8,}")
            let passwordtesting = NSPredicate(format: "SELF MATCHES %@", passwordreg)
            return passwordtesting.evaluate(with: mypassword)
        }
    
    private func validationOfPassword(){
        guard let newPassword = newPasswordTF, let confirmPassword = confirmPasswordTF else{return}
        let newPasswordValidated = validpassword(mypassword: newPassword.text ?? "")
        let confirmpasswordValidated = validpassword(mypassword: confirmPassword.text ?? "")
        if newPasswordValidated == true && confirmpasswordValidated == true{
            if passwordValidator.validatePassword(textField: newPassword) && passwordValidator.validatePassword(textField: confirmPassword){
                if newPassword.text == confirmPassword.text{
                    warningView.isHidden = true
                    self.continueButtonStatusChange(buttonTitleColor: UIColor(red: 0.09, green: 0.20, blue: 0.00, alpha: 1.00), buttonBackgroundColor: UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00), userInteraction: true)
                }else{
                    warningView.isHidden = false
                    continueButtonStatusChange(buttonTitleColor: UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.6), buttonBackgroundColor: UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.2), userInteraction: false)
                }
            }else{
                warningView.isHidden = false
                continueButtonStatusChange(buttonTitleColor: UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.6), buttonBackgroundColor: UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.2), userInteraction: false)
            }
        }else{
            warningView.isHidden = false
            continueButtonStatusChange(buttonTitleColor: UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.6), buttonBackgroundColor: UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.2), userInteraction: false)
        }
    }
    
    //MARK: - Action Events
    @IBAction func privacyPolicyButton(_ sender: UIButton) {
        
    }
    
    @IBAction func continueButton(_ sender: UIButton) {
        let vc: personalDetailVC = personalDetailVC.instantiateViewController(identifier: .signUp)
        if let newPassword = newPasswordTF.text, let confirmPassword = confirmPasswordTF.text{
            vc.password["newPassword"] = newPassword
            vc.password["confirmPassword"] = confirmPassword
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func newPasswordTF(_ sender: UITextField) {
        self.validationOfPassword()
    }
    
    @IBAction func newPasswordButton(_ sender: UIButton) {
        
    }
    
    @IBAction func confirmPasswordTF(_ sender: UITextField) {
        self.validationOfPassword()
    }
    
    @IBAction func confirmPasswordButton(_ sender: UIButton) {
    }
    
    @IBAction func rememberMeButton(_ sender: UIButton) {
        (rememberMe) ? (rememberMeButton.setImage(UIImage(named: "Tick_Remember"), for: .normal)) : (rememberMeButton.setImage(UIImage(named: "Untick_Remember"), for: .normal))
        rememberMe = !rememberMe
    }
    
    @IBAction func showPassword(_ sender: UIButton) {
        if rememberMe {
            passwordHideShow(showPassTitle: "Hide Password", secureTextEntry: false)
        } else {
            passwordHideShow(showPassTitle: "Show Password", secureTextEntry: true)
        }
        rememberMe = !rememberMe
    }
}
