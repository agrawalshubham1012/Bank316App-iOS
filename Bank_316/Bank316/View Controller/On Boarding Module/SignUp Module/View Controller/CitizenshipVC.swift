//
//  CitizenshipVC.swift
//  Bank 316
//
//  Created by Dhairya on 28/08/23.
//

import UIKit

class CitizenshipVC: UIViewController {

    @IBOutlet weak var taxResidencyView: UIView!
    @IBOutlet weak var taxResidencyNameLabel: UILabel!
    @IBOutlet weak var taxResidencyLogoImage: UIImageView!
    @IBOutlet weak var citizenshipCountryNameLabel: UILabel!
    @IBOutlet weak var citizenshipCountryLogoImage: UIImageView!
    @IBOutlet weak var citizenShipView: UIView!
    
    var personalDetalis: [String: Any] = ["country": String.self, "streetAddress": String.self, "apartment": String.self, "city": String.self, "newPassword": String.self, "confirmPassword": String.self, "postCode": String.self, "state": String.self, "firstName": String.self, "lastName": String.self, "emailAddress": String.self, "dateOfBirth": String.self]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
   
    private func updateUI(){
        let citizenshipTap = UITapGestureRecognizer(target: self, action: #selector(tapCitizenship(_:)))
        self.citizenShipView.addGestureRecognizer(citizenshipTap)
        
        let taxTap = UITapGestureRecognizer(target: self, action: #selector(tapTaxResidency(_:)))
        self.taxResidencyView.addGestureRecognizer(taxTap)
    }

    //MARK: - Action Events
    @objc func tapCitizenship(_ sender: UITapGestureRecognizer){
        let vc: CountryListVC = CountryListVC.instantiateViewController(identifier: .signUp)
        vc.identifier = "Login"
        vc.dataIdentifier = "Citizenship"
        vc.modalPresentationStyle = .overFullScreen
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
    @objc func tapTaxResidency(_ sender: UITapGestureRecognizer){
        let vc: CountryListVC = CountryListVC.instantiateViewController(identifier: .signUp)
        vc.identifier = "Login"
        vc.dataIdentifier = "Tax Residency"
        vc.modalPresentationStyle = .overFullScreen
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
    @IBAction func continueButton(_ sender: UIButton) {
        let vc: TermsAndConditionVC = TermsAndConditionVC.instantiateViewController(identifier: .signUp)
        vc.personalDetalis["firstName"] = personalDetalis["firstName"]
        vc.personalDetalis["lastName"] = personalDetalis["lastName"]
        vc.personalDetalis["emailAddress"] = personalDetalis["emailAddress"]
        vc.personalDetalis["dateOfbirth"] = personalDetalis["dateOfBirth"]
        vc.personalDetalis["newPassword"] = personalDetalis["newPassword"]
        vc.personalDetalis["confirmPassword"] = personalDetalis["confirmPassword"]
        vc.personalDetalis["country"] = personalDetalis["country"]
        vc.personalDetalis["streetAddress"] = personalDetalis["streetAddress"]
        vc.personalDetalis["apartment"] = personalDetalis["apartment"]
        vc.personalDetalis["city"] = personalDetalis["city"]
        vc.personalDetalis["postCode"] = personalDetalis["postCode"]
        vc.personalDetalis["state"] = personalDetalis["state"]
        vc.personalDetalis["citizenship"] = citizenshipCountryNameLabel.text
        vc.personalDetalis["taxResidency"] = taxResidencyNameLabel.text
        self.navigationController?.pushViewController(vc, animated: true)
    }
}



//MARK: - Country list Delegate
extension CitizenshipVC: SelectedCountryListProtocol{
    func getCountryData(countryList: CountriesNameModel?, identifier: String) {
        if identifier == "Citizenship"{
            self.citizenshipCountryLogoImage.sd_setImageCustom(url: countryList?.country_flag ?? "")
            self.citizenshipCountryNameLabel.text = countryList?.country_name ?? ""
        }else{
            self.taxResidencyLogoImage.sd_setImageCustom(url: countryList?.country_flag ?? "")
            self.taxResidencyNameLabel.text = countryList?.country_name ?? ""
        }
    }
}
