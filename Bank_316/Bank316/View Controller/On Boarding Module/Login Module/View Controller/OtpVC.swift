//
//  OtpVC.swift
//  Bank 316
//
//  Created by Dhairya on 22/08/23.
//

import UIKit

class OtpVC: UIViewController {
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var resendOtpLabel: UILabel!
    @IBOutlet weak var otpTF1: StopPasteAction!
    @IBOutlet weak var otpTF2: StopPasteAction!
    @IBOutlet weak var otpTF3: StopPasteAction!
    @IBOutlet weak var otpTF4: StopPasteAction!
    @IBOutlet weak var continueButton: UIButton!
    
    var identifier = String()
    var emailID: String = ""
    var phoneNumber: String = ""
    var phoneCode: String = ""
    var timer: Timer?
    var secondsRemaining = 60
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        resendOtpLogin()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopTimer()
    }
    
    //MARK: - Private func update UI
    private func updateUI(){
        otpTF1.delegate = self
        otpTF2.delegate = self
        otpTF3.delegate = self
        otpTF4.delegate = self
        otpTF1.becomeFirstResponder()
        if identifier == "forgot Password"{
            descLabel.text = Localizable.forgotPasswordTextDesc
        }else{
            descLabel.text = Localizable.loginPasswordCodeDesc
        }
    }
    
    // Timer For Resend OTP
    private func resendOtpLogin(){
        if timer == nil {
            timer =  Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
                if self.secondsRemaining > 0 {
                    print ("\(self.secondsRemaining) seconds")
                    self.resendOtpLabel.text = "Resend code in \(self.secondsRemaining)s"
                    self.secondsRemaining -= 1
                } else {
                    print("Invalidateeee")
                    self.resendOtpLabel.text = "Resend code in 0s"
                    Timer.invalidate()
                }
            }
        }
    }
    
    private func stopTimer(){
        timer?.invalidate()
        timer = nil
    }
    
    //Continue Button Status
    private func continueButtonStatusChange(buttonTitleColor: UIColor, buttonBackgroundColor: UIColor){
        self.continueButton.titleLabel?.textColor = buttonTitleColor
        self.continueButton.setTitleColor(buttonTitleColor, for: .normal)
        self.continueButton.backgroundColor = buttonBackgroundColor
        
    }
    
    //MARK: - Action Events
    @IBAction func privacyPolicyButton(_ sender: UIButton) {
        
    }
    
    @IBAction func OtpTF(_ sender: UITextField) {
        
    }
    
    @IBAction func continueButton(_ sender: UIButton) {
        let otp = "\(otpTF1.text ?? "")\(otpTF2.text ?? "")\(otpTF3.text ?? "")\(otpTF4.text ?? "")"
        if identifier == "Sign Up"{
            signUpVerifyOtpApi(otp: otp)
        }else if identifier == "forgot Password"{
            self.verifyOtpApi(otp: Int(otp) ?? 0)
        }else if identifier == "login"{
            signUpVerifyOtpApi(otp: otp)
        }
    }
}

//MARK: - Extension TextField Delegate
extension OtpVC: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range:NSRange, replacementString string: String) -> Bool {
        if (range.length == 0){
            if (range.length == 0){
                switch textField{
                case otpTF1:
                    otpTF2?.becomeFirstResponder()
                case otpTF2:
                    otpTF3?.becomeFirstResponder()
                case otpTF3:
                    otpTF4?.becomeFirstResponder()
                case otpTF4:
                    continueButtonStatusChange(buttonTitleColor: UIColor(red: 0.09, green: 0.20, blue: 0.00, alpha: 1.00), buttonBackgroundColor: UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00))
                    self.continueButton.isUserInteractionEnabled = true
                default:
                    break
                }
            }
            textField.text? = string
            checkOTpField()
            return false
        }else if (range.length == 1) {
            switch textField{
            case otpTF4:
                otpTF3?.becomeFirstResponder()
            case otpTF3:
                otpTF2?.becomeFirstResponder()
            case otpTF2:
                otpTF1?.becomeFirstResponder()
            case otpTF1:
                otpTF1?.becomeFirstResponder()
            default:
                break
            }
            textField.text? = ""
            continueButtonStatusChange(buttonTitleColor: UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.6), buttonBackgroundColor: UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.2))
            self.continueButton.isUserInteractionEnabled = false
            checkOTpField()
            return false
        }
        
        return true
    }
    
    
    func checkOTpField(){
        if otpTF1.text != "" && otpTF2.text != "" && otpTF3.text != "" && otpTF4.text != "" {
            continueButtonStatusChange(buttonTitleColor: UIColor(red: 0.09, green: 0.20, blue: 0.00, alpha: 1.00), buttonBackgroundColor: UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00))
            self.continueButton.isUserInteractionEnabled = true
        }
    }
}

//MARK: - Extension for API Call

extension OtpVC{
    private func verifyOtpApi(otp: Int){
        startAnimation(view: self.view)
        let parameters = [ "email": self.emailID ,
                           "otp": otp] as [String : Any]
        
        ForgotPasswordDataManager.shared.verifyOtpManager(params: parameters) { result in
            switch result{
            case .success(let data):
                defer{
                    stopAnimation(view: self.view)
                }
                if data.status == true{
                    defaults.removeObject(forKey: token)
                    defaults.set(data.otpVerify?.token, forKey: token)
                    let vc: PaswordChangedVC = PaswordChangedVC.instantiateViewController(identifier: .forgotPassword)
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    print("Invalid OTP")
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
    
    private func signUpVerifyOtpApi(otp: String){
        startAnimation(view: self.view)
        let parameters = [ "phone_code": self.phoneCode ,
                           "phone": self.phoneNumber,
                           "otp": otp] as [String : Any]
        SignUpDataManager.shared.verifyOtpManager(params: parameters) { result in
            switch result{
            case .success(let data):
                if data.status == true{
                    if self.identifier == "login"{
                        if data.isComplete ?? false {
                            let vc: DvTabBarController = DvTabBarController.instantiateViewController(identifier: .home)
                            self.navigationController?.pushViewController(vc, animated: true)
                        }else{
                            let vc: CreatePasswordVC = CreatePasswordVC.instantiateViewController(identifier: .signUp)
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }else{
                        let vc: CreatePasswordVC = CreatePasswordVC.instantiateViewController(identifier: .signUp)
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }else{
                    print("False")
                }
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
