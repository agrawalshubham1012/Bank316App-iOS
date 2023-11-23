//
//  personalDetailVC.swift
//  Bank 316
//
//  Created by Dhairya on 24/08/23.
//

import UIKit
import SkyFloatingLabelTextField

class personalDetailVC: UIViewController {
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var countryLogoImage: UIImageView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var referalCodeTF: SkyFloatingLabelTextField!
    @IBOutlet weak var livingCountryView: UIView!
    @IBOutlet weak var DOByearTF: SkyFloatingLabelTextField!
    @IBOutlet weak var DOBmonthTF: SkyFloatingLabelTextField!
    @IBOutlet weak var DOBdayTF: SkyFloatingLabelTextField!
    @IBOutlet weak var emaiAddressTF: SkyFloatingLabelTextField!
    @IBOutlet weak var lastNameTF: SkyFloatingLabelTextField!
    @IBOutlet weak var firstNameTF: SkyFloatingLabelTextField!
    
    private var emailValidation = ValidateEmailPassword()
    internal var password: [String : Any] = ["newPassword": String.self, "confirmPassword": String.self]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       updateUI()
    }
    
    //MARK: - Private func to updateUI
    private func updateUI(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapLivingCountryView(_:)))
        self.livingCountryView.addGestureRecognizer(tap)
    }
    
    private func continueButtonStatusChange(buttonTitleColor: UIColor, buttonBackgroundColor: UIColor, userInteraction: Bool){
        self.continueButton.titleLabel?.textColor = buttonTitleColor
        self.continueButton.setTitleColor(buttonTitleColor, for: .normal)
        self.continueButton.backgroundColor = buttonBackgroundColor
        self.continueButton.isEnabled = userInteraction
    }
    
    //Email ID Validation
    private func validateEmail(){
        if emailValidation.validateEmail(textField: emaiAddressTF, buttonStatus: self.continueButton){
            if firstNameTF.text?.isEmpty == false && lastNameTF.text?.isEmpty == false && DOBdayTF.text?.isEmpty == false && DOBmonthTF.text?.isEmpty == false && DOByearTF.text?.isEmpty == false{
                self.continueButtonStatusChange(buttonTitleColor: UIColor(red: 0.09, green: 0.20, blue: 0.00, alpha: 1.00), buttonBackgroundColor: UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00), userInteraction: true)
                self.continueButton.isEnabled = true
            }else{
                self.continueButtonStatusChange(buttonTitleColor: UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.6), buttonBackgroundColor: UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.2), userInteraction: false)
                self.continueButton.isEnabled = false
            }
        }else{
            self.continueButtonStatusChange(buttonTitleColor: UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.6), buttonBackgroundColor: UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.2), userInteraction: false)
            self.continueButton.isEnabled = false
        }
    }
    
    //MARK: - Action Events
    @objc func tapLivingCountryView(_ sender: UITapGestureRecognizer){
        let vc: CountryListVC = CountryListVC.instantiateViewController(identifier: .signUp)
        vc.identifier = "Login"
        vc.modalPresentationStyle = .overFullScreen
        vc.delegate = self
        self.present(vc, animated: true)
    }
     
    @IBAction func emailAddressTF(_ sender: UITextField) {
        validateEmail()
    }
    
    @IBAction func privacyPolicyButton(_ sender: UIButton) {
        
    }
    
    @IBAction func continueButton(_ sender: Any) {
        let vc: PostCodeVC = PostCodeVC.instantiateViewController(identifier: .signUp)
        if let firstName = firstNameTF.text, let lastName = lastNameTF.text, let emailAddress = emaiAddressTF.text{
            vc.personalDetalis["firstName"] = firstName
            vc.personalDetalis["lastName"] = lastName
            vc.personalDetalis["emailAddress"] = emailAddress
            vc.personalDetalis["dateOfbirth"] = "\(DOByearTF.text ?? "")-\(DOBmonthTF.text ?? "")-\(DOBdayTF.text ?? "")"
            vc.personalDetalis["newPassword"] = password["newPassword"]
            vc.personalDetalis["confirmPassword"] = password["confirmPassword"]
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

    //MARK: - Country list Delegate
extension personalDetailVC: SelectedCountryListProtocol{
    func getCountryData(countryList: CountriesNameModel?, identifier: String) {
        self.countryLogoImage.sd_setImageCustom(url: countryList?.country_flag ?? "")
        self.countryNameLabel.text = countryList?.country_name ?? ""
    }
}
