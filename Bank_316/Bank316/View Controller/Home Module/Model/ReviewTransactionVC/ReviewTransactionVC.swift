//
//  ReviewTransactionVC.swift
//  Bank 316
//
//  Created by Smt MacMini 3 on 14/11/23.
//

import UIKit
import StripeCore
import PassKit
import StripeApplePay

class ReviewTransactionVC: UIViewController,ApplePayContextDelegate {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var addedMoneyLabel: UILabel!
    @IBOutlet weak var transactionMethodLabel: UILabel!
    @IBOutlet weak var toWalletLabel: UILabel!
    @IBOutlet weak var feeLabel: UILabel!
    @IBOutlet weak var finalAmountLabel: UILabel!
    @IBOutlet weak var applePayButton: PKPaymentButton!
    @IBOutlet weak var checkMarkButton: UIButton!
    private var paymentIntentClientSecret: String?
    @IBOutlet weak var continueButtonView: UIView!
    var isCheck: Bool? = true
    var transactionData: TransactionModel?
    var finalAmount: Double?
    var cardDetails:Card?
    var webUrl:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI(){
        if let data = transactionData {
            self.addedMoneyLabel.text = "\(data.addedMoney ?? "") \(data.toWallet ?? "")"
            self.transactionMethodLabel.text = TransactionMethod(rawValue: data.transactionMethod?.rawValue ?? "")?.title
            self.toWalletLabel.text = "\(data.toWallet ?? "") Wallet"
            self.feeLabel.text = "\(data.totalFee ?? "") \(data.toWallet ?? "")"
            self.finalAmountLabel.text = "\(self.calculateFinalAmount(data: data)) \(data.toWallet ?? "")"
            self.attributeText(data:data)
            if transactionData?.transactionMethod == .card || transactionData?.transactionMethod == .easyBank {
                self.continueButtonView.isHidden = false
                self.applePayButton.isHidden = true
            }else{
                self.continueButtonView.isHidden = true
                self.applePayButton.isHidden = false
            }
            
            applePayButton.isHidden = !StripeAPI.deviceSupportsApplePay()
            applePayButton.addTarget(self, action: #selector(handleApplePayButtonTapped), for: .touchUpInside)
        }
    }
    
    
    func calculateFinalAmount(data:TransactionModel) -> String{
        let addedMoney = Double(data.addedMoney ?? "0.0") ?? 0.0
        let decimalCount = addedMoney.numberOfDecimalPlaces
        let transactionFee = Double(data.totalFee ?? "0.0") ?? 0.0
        self.finalAmount = addedMoney - transactionFee
        let stringAmount = self.finalAmount?.setDecimalCount(count:decimalCount < 2 ? 2 : decimalCount) ?? ""
        return stringAmount
    }
    
    
    func attributeText(data:TransactionModel){
        let colorString:String = "exactly \(self.finalAmountLabel.text ?? "")"
        let amountText = "An amount of \(colorString) is estimated to reach your wallet instantly."
        let attributedString = NSMutableAttributedString(string: amountText)
        // Find the range of the text you want to color differently
        if let range = amountText.range(of: colorString) {
            let nsRange = NSRange(range, in: amountText)
            // Apply red color to the specified range
            attributedString.addAttribute(.foregroundColor, value: UIColor.lemonGreen, range: nsRange)
        }
        // Apply the attributed string to the label
        self.headerLabel.attributedText = attributedString
    }
    
    
    @IBAction func editTransactionDataButton(_ sender: UIButton) {
    
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func checkMarkButton(_ sender: UIButton) {
        self.isCheck = !(isCheck ?? false)
        if isCheck ?? false {
            self.checkMarkButton.setImage(UIImage(named: "checkMark"), for: .normal)
        }else{
            self.checkMarkButton.setImage(UIImage(named: "uncheckMark"), for: .normal)
        }
    }
    
    
    @IBAction func continueButton(_ sender: UIButton) {
        if transactionData?.transactionMethod == .easyBank {
            navigateToTransactionWebView(url: self.webUrl ?? "")
        }else{
            let vc: ReviewCardTransactionVC = ReviewCardTransactionVC.instantiateViewController(identifier: .transaction)
            vc.transactionAmount = self.finalAmount?.setDecimalCount(count:2) ?? "0.00"
            vc.cardDetails = self.cardDetails
            vc.transactionData = self.transactionData
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func navigateToTransactionWebView(url:String) {
        let vc: EasyBankTransactionWebViewVC = EasyBankTransactionWebViewVC.instantiateViewController(identifier: .transaction)
        vc.webUrl = url
        vc.addedMOney = self.transactionData?.addedMoney ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @objc func handleApplePayButtonTapped() {
        let merchantIdentifier = "merchant.com.316bank"
        let paymentRequest = StripeAPI.paymentRequest(withMerchantIdentifier: merchantIdentifier, country: WalletCode(rawValue: transactionData?.toWallet ?? "")?.countryCode ?? "GB", currency: transactionData?.toWallet ?? "GBP")
        
        let stringAmount = self.finalAmount?.setDecimalCount(count:2) ?? ""
        let decimalNumber = NSDecimalNumber(value: Double(stringAmount) ?? 0.0)
        paymentRequest.paymentSummaryItems = [
            // The final line should represent your company;
            // it'll be prepended with the word "Pay" (that is, "Pay iHats, Inc $50")
            PKPaymentSummaryItem(label: "Bank316", amount: decimalNumber),
        ]
        
        // Initialize an STPApplePayContext instance
        if let applePayContext = STPApplePayContext(paymentRequest: paymentRequest, delegate: self) {
            // Present Apple Pay payment sheet
            applePayContext.presentApplePay(on: self)
        } else {
            print("There is a problem with your Apple Pay configuration")
        }
    }
}


extension ReviewTransactionVC {
    func applePayContext(_ context: STPApplePayContext, didCreatePaymentMethod paymentMethod: StripeAPI.PaymentMethod, paymentInformation: PKPayment, completion: @escaping STPIntentClientSecretCompletionBlock) {
        let clientSecret = "sk_test_51JNCruJlyaU3sS1mEKlcT8hoYbasP8AWGmxjo2nKUNEZ1mz5HyqrDo4B1jYhsfbS3j6zJzq7SGR2Mb6uQzWkK1gs00pm206cKn"
        completion(clientSecret, nil)
    }
    
    func applePayContext(_ context: STPApplePayContext, didCompleteWith status: STPApplePayContext.PaymentStatus, error: Error?) {
        switch status {
        case .success:
            print("succeeded")
            self.applePayTransactionAPI()
            break
        case .error:
            if let error = error as? NSError {
                print("Payment failed with error: \(error.localizedDescription)")
            } else {
                print("Payment failed")
            }
            break
        case .userCancellation:
            print("userCancellation")
            break
        }
    }
    
    func applePayTransactionAPI(){
        startAnimation(view: self.view)
        let url = "\(String(describing: addMoney))\(self.transactionData?.walletID ?? "")"
        let transactionAmount = Double(transactionData?.addedMoney ?? "")
        
        let param:[String:Any] = [
            "amount":transactionAmount ?? 0.0,
            "paymentType":"google-pay",
            "multiUsePaymentId":"hskjappos"
        ]
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
    
    func navigateToView(status:Bool,message:String,description:String,error:String?){
        if !status {
            let vc: FailureTransactionVC = FailureTransactionVC.instantiateViewController(identifier: .transaction)
            vc.apiError = error
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc: CompleteTransactionVC = CompleteTransactionVC.instantiateViewController(identifier: .transaction)
            vc.transactionAmount = self.finalAmount?.setDecimalCount(count:2) ?? "0.00"
            vc.toWallet = transactionData?.toWallet ?? "GBP"
            vc.fromView = .applePay
            vc.apiDescription = description
            vc.headerLabel = message
            print(transactionData as Any)
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
