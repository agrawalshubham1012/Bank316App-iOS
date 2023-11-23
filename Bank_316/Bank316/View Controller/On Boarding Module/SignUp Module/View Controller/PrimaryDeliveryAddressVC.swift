//
//  PrimaryDeliveryAddressVC.swift
//  Bank 316
//
//  Created by Dhairya on 28/08/23.
//

import UIKit

class PrimaryDeliveryAddressVC: UIViewController {

    var personalDetalis: [String: Any] = ["country": String.self, "streetAddress": String.self, "apartment": String.self, "city": String.self, "newPassword": String.self, "confirmPassword": String.self, "postCode": String.self, "state": String.self, "firstName": String.self, "lastName": String.self, "emailAddress": String.self, "dateOfBirth": String.self]
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    //MARK: - ACtion Events
    @IBAction func doItLater(_ sender: UIButton) {
        
    }
    @IBAction func continueButton(_ sender: UIButton) {
        let vc: CitizenshipVC = CitizenshipVC.instantiateViewController(identifier: .signUp)
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
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
