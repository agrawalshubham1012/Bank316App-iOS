//
//  PrefillVC.swift
//  Bank 316
//
//  Created by Dhairya on 28/08/23.
//

import UIKit
import SkyFloatingLabelTextField

class PrefillVC: UIViewController {
    
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var countryLogoImage: UIImageView!
    @IBOutlet weak var postCodeTF: UITextField!
    @IBOutlet weak var cityTF: SkyFloatingLabelTextField!
    @IBOutlet weak var stateTF: SkyFloatingLabelTextField!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var apartmentTF: SkyFloatingLabelTextField!
    @IBOutlet weak var streetAddressTF: SkyFloatingLabelTextField!
    @IBOutlet weak var countryView: UIView!
    
    var personalDetalis: [String: Any] = ["country": String.self, "streetAddress": String.self, "apartment": String.self, "city": String.self, "newPassword": String.self, "confirmPassword": String.self, "postCode": String.self, "state": String.self, "firstName": String.self, "lastName": String.self, "emailAddress": String.self, "dateOfBirth": String.self]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    private func updateUI(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapLivingCountryView(_:)))
        self.countryView.addGestureRecognizer(tap)
        if personalDetalis["postCode"] as? String ?? "" == ""{
            postCodeTF.isUserInteractionEnabled = true
        }else{
            postCodeTF.text = personalDetalis["postCode"].unsafelyUnwrapped as? String ?? ""
            postCodeTF.isUserInteractionEnabled = false
        }
        
    }
    
    private func continueButtonStatusChange(buttonTitleColor: UIColor, buttonBackgroundColor: UIColor, userInteraction: Bool){
        self.continueButton.titleLabel?.textColor = buttonTitleColor
        self.continueButton.setTitleColor(buttonTitleColor, for: .normal)
        self.continueButton.backgroundColor = buttonBackgroundColor
        self.continueButton.isEnabled = userInteraction
    }
    
    //MARK: - Action Events
    
    @IBAction func continueButton(_ sender: Any) {
        let vc: PrimaryDeliveryAddressVC = PrimaryDeliveryAddressVC.instantiateViewController(identifier: .signUp)
        if let country = countryNameLabel.text, let state = stateTF.text, let streetAddress = streetAddressTF.text, let apartment = apartmentTF.text, let postCode = postCodeTF.text, let city = cityTF.text{
            vc.personalDetalis["firstName"] = personalDetalis["firstName"]
            vc.personalDetalis["lastName"] = personalDetalis["lastName"]
            vc.personalDetalis["emailAddress"] = personalDetalis["emailAddress"]
            vc.personalDetalis["dateOfbirth"] = personalDetalis["dateOfBirth"]
            vc.personalDetalis["newPassword"] = personalDetalis["newPassword"]
            vc.personalDetalis["confirmPassword"] = personalDetalis["confirmPassword"]
            vc.personalDetalis["country"] = country
            vc.personalDetalis["streetAddress"] = streetAddress
            vc.personalDetalis["apartment"] = apartment
            vc.personalDetalis["city"] = city
            vc.personalDetalis["postCode"] = postCode
            vc.personalDetalis["state"] = state
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func addressTF(_ sender: UITextField) {
        if streetAddressTF.text?.isEmpty == false && apartmentTF.text?.isEmpty == false && cityTF.text?.isEmpty == false && postCodeTF.text?.isEmpty == false{
            self.continueButtonStatusChange(buttonTitleColor: UIColor(red: 0.09, green: 0.20, blue: 0.00, alpha: 1.00), buttonBackgroundColor: UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00), userInteraction: true)
            self.continueButton.isEnabled = true
        }else{
            self.continueButtonStatusChange(buttonTitleColor: UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.6), buttonBackgroundColor: UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.2), userInteraction: false)
            self.continueButton.isEnabled = false
        }
    }
    
    @objc func tapLivingCountryView(_ sender: UITapGestureRecognizer){
        let vc: CountryListVC = CountryListVC.instantiateViewController(identifier: .signUp)
        vc.identifier = "Login"
        vc.modalPresentationStyle = .overFullScreen
        vc.delegate = self
        self.present(vc, animated: true)
    }
}

//MARK: - Country list Delegate
extension PrefillVC: SelectedCountryListProtocol{
    func getCountryData(countryList: CountriesNameModel?, identifier: String) {
        self.countryLogoImage.sd_setImageCustom(url: countryList?.country_flag ?? "")
        self.countryNameLabel.text = countryList?.country_name ?? ""
    }
}
