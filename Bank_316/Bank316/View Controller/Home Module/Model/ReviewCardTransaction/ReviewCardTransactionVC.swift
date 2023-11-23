//
//  ReviewCardTransactionVC.swift
//  Bank 316
//
//  Created by Smt MacMini 3 on 16/11/23.
//

import UIKit
import StripePaymentsUI

class ReviewCardTransactionVC: UIViewController {
    
    @IBOutlet weak var transactionDetailLabel: UILabel!
    @IBOutlet weak var selectedCardImage: UIImageView!
    var transactionAmount:String?
    var cardDetails:Card?
    var transactionData: TransactionModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
    }
    
    func setUI(){
        self.attributeText()
        let cardBrand = STPCardValidator.brand(forNumber: cardDetails?.cardNumber ?? "")
        let cardBrandImageName = cardBrand.cardBrandImage()
        self.selectedCardImage.image = cardBrandImageName
    }
 
    func attributeText(){
        let transactionAmount:String = "\(self.transactionData?.currencySymbol ?? "")\(self.transactionAmount ?? "")"
        let amountText = "Continue to your bank to confirm this deposit of \(transactionAmount) to your 316 \(self.transactionData?.toWallet ?? "") account."
        let attributedString = NSMutableAttributedString(string: amountText)
        if let range = amountText.range(of: amountText) {
            _ = NSRange(range, in: amountText)
        }
        self.transactionDetailLabel.attributedText = attributedString
    }
    
    
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func continueButton(_ sender: UIButton) {
        print(transactionData as Any)
        print(self.cardDetails as Any)
        self.adMoneyToWalletAPI()
    }
    
}

extension ReviewCardTransactionVC {
    private func adMoneyToWalletAPI(){
        startAnimation(view: self.view)
        let url = "\(String(describing: addMoney))\(self.transactionData?.walletID ?? "")"
        let transactionAmount = Double(transactionData?.addedMoney ?? "")
        
        let cardData:[String:Any] = [
            "cardNumber": cardDetails?.cardNumber ?? 0,
            "expiryMonths": cardDetails?.expiryMonth ?? 0,
            "expiryYear": cardDetails?.expiryYear ?? 0,
            "cvc": cardDetails?.cvc ?? 0
        ]
        
        let param:[String:Any] = ["amount":transactionAmount ?? 0,"paymentType":"card","card":cardData]
        
        print(param)
        
        APIDataManager.shared.postData(url:url, param:param) { (result:ResultSet< AddMoneyCardResponseModel,ServerError>) in
            switch result{
            case .success(let data):
                defer{
                    stopAnimation(view: self.view)
                }
                let status = data.status ?? false
                self.navigateToView(status:status,message:data.message ?? "",description: data.description ?? "", error:data.message)
                print(data)
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
    
    func navigateToView(status:Bool,message:String,description:String,error:String?){
        if !status {
            let vc: FailureTransactionVC = FailureTransactionVC.instantiateViewController(identifier: .transaction)
            vc.apiError = error
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc: CompleteTransactionVC = CompleteTransactionVC.instantiateViewController(identifier: .transaction)
            vc.apiDescription = description
            vc.headerLabel = message
            vc.fromView = .cardFlow
            vc.cardNumber = cardDetails?.cardNumber ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
