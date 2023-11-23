//
//  AddCardVC.swift
//  Bank 316
//
//  Created by Smt MacMini 3 on 17/11/23.
//

import UIKit
import StripePaymentsUI


class AddCardVC: UIViewController, STPPaymentCardTextFieldDelegate {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var inputCardFieldView: UIView!
    @IBOutlet weak var brandImage: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var default316Image: UIImageView!
    
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var accountHolderNameLabel: UILabel!
    @IBOutlet weak var expiryMonthYearLabel: UILabel!
    @IBOutlet weak var cvvLabel: UILabel!
    @IBOutlet weak var hideCardNumberImage: UIImageView!
    
    @IBOutlet var bigView: UIView!
    
    var cardParams = STPCardParams()
    var ishide:Bool = false
    var cardValid:Bool = false
    
    lazy var cardTextField: STPPaymentCardTextField = {
        let cardTextField = STPPaymentCardTextField()
        return cardTextField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
    }
    
    func setUI(){
        self.accountHolderNameLabel.text = UserDataManager.shared.userName ?? ""
        self.saveButton.setTitle("Cancel", for: .normal)
        self.default316Image?.image?.roundedImage(cornerRadius: 20, corners: [.topRight])
        self.default316Image.clipsToBounds = true
       
        cardTextField.delegate = self
        cardTextField.translatesAutoresizingMaskIntoConstraints = false
        cardTextField.textColor = .white
        cardTextField.borderColor = .clear
        cardTextField.backgroundColor = .lightAppGreen
        cardTextField.postalCodeEntryEnabled = false
        cardTextField.placeholderColor = .textPlaceHolderColor
        self.inputCardFieldView.addSubview(cardTextField)
        NSLayoutConstraint.activate([
            cardTextField.leftAnchor.constraint(equalToSystemSpacingAfter: inputCardFieldView.leftAnchor, multiplier: 0),
            cardTextField.rightAnchor.constraint(equalToSystemSpacingAfter: inputCardFieldView.rightAnchor, multiplier: 0),
            cardTextField.widthAnchor.constraint(equalToConstant: 500),
            cardTextField.topAnchor.constraint(equalToSystemSpacingBelow: inputCardFieldView.topAnchor, multiplier: 0),cardTextField.bottomAnchor.constraint(equalToSystemSpacingBelow: inputCardFieldView.bottomAnchor, multiplier: 0),
        ])
    }
    
    func paymentCardTextFieldDidChange(_ textField: STPPaymentCardTextField) {
        self.cardParams.number = textField.cardNumber
        self.cardParams.expMonth = UInt(textField.expirationMonth)
        self.cardParams.expYear = UInt(textField.expirationYear)
        self.cardParams.cvc = textField.cvc
        self.setCardDetails()
        self.setButtonUI()
        let cardBrand = STPCardValidator.brand(forNumber: cardParams.number ?? "")
        let cardBrandImageName = self.cardBrandImageName(for: cardBrand)
        self.brandImage?.image = cardBrandImageName
    }
    
    
    func setButtonUI(){
        if STPCardValidator.validationState(forCard: cardParams) == .valid{
            self.cardValid = true
            self.saveButton.setTitle("Save", for: .normal)
        }else{
            self.cardValid = false
            self.saveButton.setTitle("Cancel", for: .normal)
        }
    }
    
    
    func setCardDetails(){
        if self.ishide {
            self.cardNumberLabel.text  = cardParams.number?.hideDigits()
            self.cvvLabel.text = cardParams.cvc?.hideDigits()
        }else{
            self.cardNumberLabel.text  = cardParams.number
            self.cvvLabel.text = cardParams.cvc
        }
        if cardParams.expMonth != 0 && cardParams.expYear != 0 {
            self.expiryMonthYearLabel.text = "\(formatText("\(cardParams.expMonth)"))/\(cardParams.expYear)"
        }else if cardParams.expMonth != 0 && cardParams.expYear == 0  {
            self.expiryMonthYearLabel.text = "\(formatText("\(cardParams.expMonth)"))/"
        }else{
            self.expiryMonthYearLabel.text = ""
        }
    }
    
    
    
    func formatText(_ text: String) -> String {
        if text.count < 10 {
            if let number = Int(text) {
                return String(format: "%02d", number)
            }
        }
        return text
    }
    
    
    func cardBrandImageName(for brand: STPCardBrand) -> UIImage? {
        switch brand {
        case .amex:
            return STPImageLibrary.amexCardImage()
        case .visa:
            return STPImageLibrary.visaCardImage()
        case .mastercard:
            return STPImageLibrary.mastercardCardImage()
        case .discover:
            return STPImageLibrary.discoverCardImage()
        case .JCB:
            return STPImageLibrary.jcbCardImage()
        case .dinersClub:
            return STPImageLibrary.dinersClubCardImage()
        case .unionPay:
            return STPImageLibrary.unionPayCardImage()
        case .unknown:
            return STPImageLibrary.unknownCardCardImage()
        @unknown default:
            return UIImage()
        }
    }
    
    
    @IBAction func hideShowButton(_ sender: UIButton) {
        
        self.ishide = !ishide
        
        if !ishide {
            self.cardNumberLabel.text  = cardParams.number
            self.cvvLabel.text = cardParams.cvc
            self.hideCardNumberImage.image = UIImage(named: "eye")
        } else {
            self.cardNumberLabel.text  = self.cardNumberLabel.text?.hideDigits()
            self.cvvLabel.text = self.cvvLabel.text?.hideDigits()
            self.hideCardNumberImage.image = UIImage(named: "hidePassword")
        }
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        if self.cardValid {
            self.addCardAPI()
        }
    }
    
}


extension AddCardVC {
    private func addCardAPI(){
        startAnimation(view: self.view)
        let url = addCard
        let cardDetails:[String:Any] = [
            "cardNumber": cardParams.number ?? "",
            "expiryMonths": cardParams.expMonth ,
            "expiryYear": cardParams.expYear ,
            "cvc": Int(cardParams.cvc ?? "") ?? 0
        ]
        
        let param:[String:Any] = [ "card": cardDetails]
        print(param)
        
        self.bigView.backgroundColor = .appGreen
        APIDataManager.shared.postData(url:url, param:param) { (result:ResultSet< AddCardResponseModel,ServerError>) in
            switch result{
            case .success(let data):
                defer{
                    stopAnimation(view: self.view)
                }
                print(data)
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            case .failure(let error):
                stopAnimation(view: self.view)
                let error = error.getErrorMessage()
                self.setAlert(message:error)
            }
        }
    }
    
    func setAlert(message:String){
        let popupVC: PopUpViewController = PopUpViewController.instantiateViewController(identifier: .home)
        popupVC.message = message
        popupVC.imageHide = true
        popupVC.modalPresentationStyle = .overCurrentContext
        popupVC.modalTransitionStyle = .crossDissolve
        self.navigationController?.present(popupVC, animated: true, completion: nil)
    }
}
