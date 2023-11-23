//
//  loginPageVC.swift
//  Bank316
//
//  Created by Iplexuss Software Solutions on 17/08/23.
//

import UIKit
import IQKeyboardManagerSwift
import CountryPickerView
import NVActivityIndicatorView
import UserNotifications

class loginPageVC: UIViewController {
    
    @IBOutlet weak var phoneNumberVIew: UIView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var lockImage: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var countryCodeLabel: UILabel!
    @IBOutlet weak var countryFlagImage: UIImageView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var phoneNumberTF: UITextField!
    @IBOutlet weak var privacyPolicyButton: UIButton!
    @IBOutlet weak var signUpView: UIView!
    @IBOutlet weak var sendOtpButton: UIButton!
    @IBOutlet weak var emailTf: UITextField!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var forgotPassword: UIButton!
    @IBOutlet weak var passwordTf: StopPasteAction!
    @IBOutlet weak var showPasswordButton: UIButton!
    @IBOutlet weak var rememberMeButton: UIButton!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var countryView: UIView!
    
    var rememberMe:Bool = false
    private var emailValidation = ValidateEmailPassword()
    private var getLoginType = "Email"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        notificationPermission()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.countryView.layer.cornerRadius = 6.0
        self.phoneNumberVIew.layer.cornerRadius = 6.0
    }
    
    //MARK: -  Update UI
    private func updateUI(){
        segmentControl.setTitleColor(UIColor.white)
        segmentControl.setTitleColor(UIColor.black, state: .selected)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(countryCodeTap(_:)))
        self.countryView.addGestureRecognizer(tapGesture)
        defaults.set(true, forKey: splash)
        
        if let email = UserDataManager.shared.email , let password = UserDataManager.shared.password {
            self.emailTf.text = email
            self.passwordTf.text = password
            self.rememberMe = true
            self.rememberMeButton.setImage(UIImage(named: "Tick_Remember"), for: .normal)
            
        }else{
            self.rememberMe = false
            self.rememberMeButton.setImage(UIImage(named: "Untick_Remember"), for: .normal)
        }
    }
    
    
    private func segmentView(_ isHideView: [Bool]){
        loginView.isHidden = isHideView.first ?? true
        signUpView.isHidden = isHideView.last ?? true
    }
    
    private func otpButtonStatus(otpTitle: String, otpBackgroundColor: UIColor, otpTitleColor: UIColor, userInteraction: Bool){
        self.sendOtpButton.setTitle(otpTitle, for: .normal)
        self.sendOtpButton.backgroundColor = otpBackgroundColor
        self.sendOtpButton.setTitleColor(otpTitleColor, for: .normal)
        self.sendOtpButton.isUserInteractionEnabled = userInteraction
    }
    
    private func continueButtonStatusChange(buttonTitleColor: UIColor, buttonBackgroundColor: UIColor, userInteraction: Bool){
        self.continueButton.titleLabel?.textColor = buttonTitleColor
        self.continueButton.setTitleColor(buttonTitleColor, for: .normal)
        self.continueButton.backgroundColor = buttonBackgroundColor
        
    }
    
    //Email ID Validation
    private func validateEmail(){
        if emailValidation.validateEmail(textField: emailTf, buttonStatus: self.continueButton){
            self.continueButtonStatusChange(buttonTitleColor: UIColor(red: 0.09, green: 0.20, blue: 0.00, alpha: 1.00), buttonBackgroundColor: UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00), userInteraction: true)
            if let email = emailTf.text, let password = passwordTf.text{
                self.loginApi(email: email, password: password, phoneCode: "", phoneNumber: "")
            }
        }else{
            showAlert(withTitle: "Alert", message: "Please Enter Valid Email")
        }
    }
    
    //MARK: - Action Events
    
    @objc func countryCodeTap(_ sender: UITapGestureRecognizer){
        let vc: CountryListVC = CountryListVC.instantiateViewController(identifier: .signUp)
        vc.identifier = "Login"
        vc.modalPresentationStyle = .overFullScreen
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
    @IBAction func cancelPhoneNumberTxtButton(_ sender: UIButton) {
        phoneNumberTF.text?.removeAll()
        otpButtonStatus(otpTitle: "Send OTP", otpBackgroundColor: UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.2), otpTitleColor: UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.6), userInteraction: false)
        lockAndSegmentControlHidden([true , false])
    }
    
    @IBAction func forgotPassword(_ sender: UIButton) {
        let vc: forgotPasswordVC = forgotPasswordVC.instantiateViewController(identifier: .forgotPassword)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func rememberMeButton(_ sender: UIButton) {
        rememberMe = !rememberMe
        (rememberMe) ? (rememberMeButton.setImage(UIImage(named: "Tick_Remember"), for: .normal)) : (rememberMeButton.setImage(UIImage(named: "Untick_Remember"), for: .normal))
        
    }
    
    @IBAction func segmentControlValueChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            getLoginType = "Email"
            descLabel.text = Localizable.loginText
            segmentView([false, true])
        }
        else {
            getLoginType = "Phone"
            descLabel.text = Localizable.signupText
            segmentView([true, false])
        }
    }
    
    @IBAction func continueButton(_ sender: UIButton) {
        print(getLoginType)
        if getLoginType == "Email" {
            if emailTf.text == "" {
                showAlert(withTitle: "Alert", message: "Please Enter Email")
                return
            }
            else if passwordTf.text == "" {
                showAlert(withTitle: "Alert", message: "Please Enter Password")
                return
            }
            else {
                validateEmail()
            }
        }else {
            if phoneNumberTF.text == "" {
                showAlert(withTitle: "Alert", message: "Please Enter Phone Number")
                return
            }
            else {
                if let countryCode = countryCodeLabel.text , let phoneNumber = phoneNumberTF.text{
                    loginApi(email: "", password: "", phoneCode: countryCode, phoneNumber: phoneNumber)
                }
            }
        }
    }
    
    private func lockAndSegmentControlHidden(_ isLockHide: [Bool]) {
        lockImage.isHidden = isLockHide.first ?? false
        segmentControl.isHidden = isLockHide.last ?? false
    }
    
    @IBAction func phoneNumberTF(_ sender: UITextField) {
        if phoneNumberTF.text?.isEmpty == false{
            lockAndSegmentControlHidden([false , true])
            otpButtonStatus(otpTitle: "Continue", otpBackgroundColor: UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00), otpTitleColor: UIColor(red: 0.09, green: 0.20, blue: 0.00, alpha: 1.00), userInteraction: true)
        }else{
            lockAndSegmentControlHidden([true , false])
            otpButtonStatus(otpTitle: "Send OTP", otpBackgroundColor: UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.2), otpTitleColor: UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.6), userInteraction: false)
        }
    }
    
    @IBAction func showPasswordButton(_ sender: UIButton) {
        if rememberMe {
            self.passwordTf.isSecureTextEntry = false
            self.showPasswordButton.setImage(UIImage(named: "ShowPassword"), for: .normal)
        } else {
            self.passwordTf.isSecureTextEntry = true
            self.showPasswordButton.setImage(UIImage(named: "hidePassword"), for: .normal)
        }
        rememberMe = !rememberMe
    }
    
    @IBAction func signUpButton(_ sender: UIButton) {
        // let vc: SelfieVC = SelfieVC.instantiateViewController(identifier: .verification)
        // self.navigationController?.pushViewController(vc, animated: true)
        let vc: SignUpVC = SignUpVC.instantiateViewController(identifier: .signUp)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func sendOTPButton(_ sender: UIButton) {
        print(getLoginType)
        //getLoginType = "Email"
        if let countryCode = countryCodeLabel.text , let phoneNumber = phoneNumberTF.text{
            loginApi(email: "", password: "", phoneCode: countryCode, phoneNumber: phoneNumber)
        }
    }
    
    @IBAction func privacyPolicyButton(_ sender: UIButton) {
        
    }
    
    func setAlert(message:String){
        let popupVC: PopUpViewController = PopUpViewController.instantiateViewController(identifier: .home)
        popupVC.message = message
        popupVC.modalPresentationStyle = .overCurrentContext
        popupVC.modalTransitionStyle = .crossDissolve
        self.navigationController?.present(popupVC, animated: true, completion: nil)
    }
    
}


extension loginPageVC {
    
    func notificationPermission() {
        let current = UNUserNotificationCenter.current()
        
        current.getNotificationSettings(completionHandler: { (settings) in
            
            if settings.authorizationStatus == .notDetermined {
                
                print("not granted yet - ask the user")
                
                current.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
                    guard error == nil, granted else {
                        print("User denied permissions, or error occurred")
                        return
                    }
                    print("Permissions granted")
                }
            } else if settings.authorizationStatus == .denied {
                DispatchQueue.main.async {
                    self.showSettingsAlert()
                }
                print("Notification permission was previously denied, tell the user to go to settings & privacy to re-enable")
            } else if settings.authorizationStatus == .authorized {
                print("Notification permission was already granted")
            }
        })
    }
    
    func showSettingsAlert() {
        let alertController = UIAlertController(
            title: "Notification Permission Denied",
            message: "To enable notifications, please go to Settings and turn on notifications for this app.",
            preferredStyle: .alert
        )
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { _ in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(settingsAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
}


//MARK: - API Handler
extension loginPageVC {
    private func loginApi(email: String, password: String, phoneCode: String, phoneNumber: String){
        startAnimation(view: self.view)
        let parameters = [ "email": email,
                           "password": password,
                           "phone_code": phoneCode,
                           "phone": phoneNumber]
        LoginDataManager.shared.loginManager(params: parameters) { result in
            switch result{
            case .success(let data):
                print(data)
                defer{
                    stopAnimation(view: self.view)
                }
                if self.getLoginType == "Email"{
                    if data.status == true{
                        if data.data?.isComplete ?? false {
                            self.remeberMeAction()
                            let vc: DvTabBarController = DvTabBarController.instantiateViewController(identifier: .home)
                            self.navigationController?.pushViewController(vc, animated: true)
                        }else{
                            let vc: CreatePasswordVC = CreatePasswordVC.instantiateViewController(identifier: .signUp)
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }else{
                        let message = data.message
                        self.setAlert(message: message ?? "")
                    }
                }else{
                    if self.sendOtpButton.titleLabel?.text == "Send OTP"{
                        return
                    }else{
                        if data.status == true{
                            let vc: OtpVC = OtpVC.instantiateViewController(identifier: .login)
                            vc.identifier = "login"
                            vc.phoneCode = self.countryCodeLabel.text ?? ""
                            vc.phoneNumber = self.phoneNumberTF.text ?? ""
                            self.navigationController?.pushViewController(vc, animated: true)
                        }else{
                            let message = data.message
                            self.setAlert(message: message ?? "")
                        }
                    }
                }
                defaults.set(data.data?.token, forKey: token)
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func remeberMeAction(){
        if self.rememberMe {
            UserDataManager.shared.email = self.emailTf.text
            UserDataManager.shared.password = self.passwordTf.text
            defaults.synchronize()
        } else {
            UserDataManager.shared.removeLoginUserCredential()
        }
    }
    
}

//MARK: - Extension for ALL Delegates
extension loginPageVC: SelectedCountryListProtocol{
    func getCountryData(countryList: CountriesNameModel?, identifier: String) {
        self.countryCodeLabel.text = countryList?.country_code
        self.countryFlagImage.sd_setImageCustom(url: countryList?.country_flag ?? "")
    }
}
