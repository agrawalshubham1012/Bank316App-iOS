//
//  TermsAndConditionVC.swift
//  Bank 316
//
//  Created by Dhairya on 14/09/23.
//

import UIKit

class TermsAndConditionVC: UIViewController {

    @IBOutlet weak var brokerTcImage: UIImageView!
    @IBOutlet weak var preContractualImage: UIImageView!
    @IBOutlet weak var orderHandleStack: UIStackView!
    @IBOutlet weak var preContractualStack: UIStackView!
    @IBOutlet weak var brokerTcStack: UIStackView!
    @IBOutlet weak var mainView: UIView!
    
    var rememberContractMe = true
    var rememberBrokerMe = true
    var personalDetalis: [String: Any] = ["country": String.self, "streetAddress": String.self, "apartment": String.self, "city": String.self, "newPassword": String.self, "confirmPassword": String.self, "postCode": String.self, "state": String.self, "firstName": String.self, "lastName": String.self, "emailAddress": String.self, "dateOfBirth": String.self, "citizenship": String.self, "taxResidency": String.self]
    override func viewDidLoad() {
        super.viewDidLoad()
       updateUI()
    }
    
    //MARK: - Private func to update UI
    private func updateUI(){
        let tapPreContractualStack = UITapGestureRecognizer(target: self, action: #selector(preContractualTapping(_:)))
        self.preContractualStack.addGestureRecognizer(tapPreContractualStack)
        
        let tapBrokerStack = UITapGestureRecognizer(target: self, action: #selector(tapbrokerTcStackTapping(_:)))
        self.orderHandleStack.addGestureRecognizer(tapBrokerStack)
        self.mainView.setRoundedManualTopCorners(cornerRadius: 30)
    }
    
    //MARK: - Action Events
    
    @objc func preContractualTapping(_ sender: UITapGestureRecognizer){
        (rememberContractMe) ? (preContractualImage.image = UIImage(named: "Country_Selected")) : (preContractualImage.image = UIImage(named: "Country_UnSelected"))
        rememberContractMe = !rememberContractMe
    }
    
    @objc func tapbrokerTcStackTapping(_ sender: UITapGestureRecognizer){
        (rememberBrokerMe) ? (brokerTcImage.image = UIImage(named: "Country_Selected")) : (brokerTcImage.image = UIImage(named: "Country_UnSelected"))
        rememberBrokerMe = !rememberBrokerMe
    }
    
    @IBAction func verifyLaterButton(_ sender: UIButton) {
        
    }
    
    @IBAction func agreeButton(_ sender: UIButton) {
        let vc: SignUpProgressVC = SignUpProgressVC.instantiateViewController(identifier: .signUp)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
   
    @IBAction func activateAllCheckBoxButton(_ sender: Any) {
        self.rememberContractMe = false
        self.rememberBrokerMe = false
        self.brokerTcImage.image = UIImage(named: "Country_Selected")
        self.preContractualImage.image = UIImage(named: "Country_Selected")
    }
}
