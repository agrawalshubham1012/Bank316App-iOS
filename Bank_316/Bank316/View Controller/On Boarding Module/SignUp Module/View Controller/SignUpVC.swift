//
//  SignUpVC.swift
//  Bank 316
//
//  Created by Dhairya on 24/08/23.
//

import UIKit
import CountryPickerView

class SignUpVC: UIViewController {
    
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var countryCodeLabel: UILabel!
    @IBOutlet weak var countryLogoImage: UIImageView!
    @IBOutlet weak var cancelNumberButton: UIButton!
    @IBOutlet weak var phoneNumberTF: UITextField!
    @IBOutlet weak var privacyPolicyButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var phoneView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.countryView.layer.cornerRadius = 6.0
        self.phoneView.layer.cornerRadius = 6.0
    }
    
    //MARK: - Private Func
    private func updateUI(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(countryCodeTap(_:)))
        self.countryView.addGestureRecognizer(tapGesture)
        
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
    
    func applyCornerRadius(view: UIView, corners: UIRectCorner, radius: CGFloat) {
            let maskPath = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))

            let maskLayer = CAShapeLayer()
            maskLayer.path = maskPath.cgPath

            view.layer.mask = maskLayer
            view.layer.masksToBounds = true
        }
    
    private func otpButtonStatus(otpBackgroundColor: UIColor, otpTitleColor: UIColor, userInteraction: Bool){
        self.continueButton.titleLabel?.textColor = otpTitleColor
        self.continueButton.setTitleColor(otpTitleColor, for: .normal)
        self.continueButton.backgroundColor = otpBackgroundColor
        self.continueButton.isUserInteractionEnabled = userInteraction
    }
    
    //MARK: - Action Events
    
    @objc func countryCodeTap(_ sender: UITapGestureRecognizer){
        //        countryList.showCountriesList(from: self)
        let vc: CountryListVC = CountryListVC.instantiateViewController(identifier: .signUp)
        vc.modalPresentationStyle = .overFullScreen
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
    
    @IBAction func cancelNumberButton(_ sender: UIButton) {
        phoneNumberTF.text?.removeAll()
        otpButtonStatus(otpBackgroundColor: UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.2), otpTitleColor: UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.6), userInteraction: false)
    }
    @IBAction func phoneNumberTF(_ sender: UITextField) {
        if phoneNumberTF.text?.isEmpty == false{
            otpButtonStatus(otpBackgroundColor: UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00), otpTitleColor: UIColor(red: 0.09, green: 0.20, blue: 0.00, alpha: 1.00), userInteraction: true)
        }else{
            otpButtonStatus(otpBackgroundColor: UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.2), otpTitleColor: UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.6), userInteraction: false)
        }
    }
    
    @IBAction func privacyPolicyButton(_ sender: UIButton) {
        
    }
    
    @IBAction func continueButton(_ sender: UIButton) {
        if phoneNumberTF.text == "" {
            showAlert(withTitle: "Alert", message: "Please Enter Phone Number")
            return
        }
        if let countryCode = countryCodeLabel.text , let phoneNumber = phoneNumberTF.text{
            signUpWithPhoneNumber(phoneCode: countryCode, phoneNumber: phoneNumber)
        }
    }
}

//MARK: - Extension to call API
extension SignUpVC{
    private func signUpWithPhoneNumber(phoneCode: String, phoneNumber: String){
        startAnimation(view: self.view)
        let parameters = [ "phone_code": phoneCode,
                           "phone": phoneNumber ]
        SignUpDataManager.shared.signUpManager(params: parameters) { result in
            switch result{
            case .success(let data):
                print(data)
                defer{
                    stopAnimation(view: self.view)
                }
                if data.status == true{
                    let vc: OtpVC = OtpVC.instantiateViewController(identifier: .login)
                    vc.identifier = "Sign Up"
                    vc.phoneCode = self.countryCodeLabel.text ?? ""
                    vc.phoneNumber = self.phoneNumberTF.text ?? ""
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    print(data.message ?? "")
                    print("False")
                    self.showAlert(withTitle: "Alert", message: data.message ?? "")
                    return
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

//MARK: - Extension for ALL Delegates
extension SignUpVC: SelectedCountryListProtocol{
    func getCountryData(countryList: CountriesNameModel?, identifier: String) {
        self.countryCodeLabel.text = countryList?.country_code
        self.countryLogoImage.sd_setImageCustom(url: countryList?.country_flag ?? "")
    }
}
