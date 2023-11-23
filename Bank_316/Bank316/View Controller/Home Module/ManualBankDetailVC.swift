//
//  ManualBankDetailVC.swift
//  Bank 316
//
//  Created by Smt MacMini 3 on 22/11/23.
//

import UIKit

class ManualBankDetailVC: UIViewController {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var payeeNameLabel: UILabel!
    @IBOutlet weak var sortCodeLabel: UILabel!
    @IBOutlet weak var accountNumberLabel: UILabel!
    @IBOutlet weak var bankNameLabel: UILabel!
    @IBOutlet weak var referenceLabel: UILabel!
    @IBOutlet weak var bankAddressLabel: UILabel!
    @IBOutlet weak var sendAmountLabel: UILabel!
    private var paymentIntentClientSecret: String?
    @IBOutlet weak var hideView: UIView!
    var bankData:ManualBankList?
    var currencyData:Wallet?
    var amountAdded:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getManualBankDetail()
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func makeMyTransferButton(_ sender: UIButton) {
        self.manualBankAddMoneyAPI()
    }
    
    @IBAction func TransferMoneyLaterButton(_ sender: UIButton) {
        self.transferMoneyLater()
    }
    
    @IBAction func needSomeHelpButton(_ sender: UIButton) {
        
    }
    
    func setUI(){
        self.hideView.isHidden = true
        let customReferenceID = generateCustomReferenceID()
        self.attributeText()
        self.payeeNameLabel.text = self.bankData?.payeeName ?? ""
        self.sortCodeLabel.text = self.bankData?.sortCode ?? ""
        self.accountNumberLabel.text = self.bankData?.accountNo ?? ""
        self.bankNameLabel.text = self.bankData?.bankName ?? ""
        self.referenceLabel.text = customReferenceID
        self.sendAmountLabel.text = self.amountAdded ?? ""
        self.bankAddressLabel.text = self.bankData?.bankAddress ?? ""
    }
    
    func attributeText(){
        let colorString:String = "exactly \(self.amountAdded ?? "") EUR"
        let amountText = "Log into your online banking and transfer \(colorString) to 316's EUR account using the reference provided below. We will credit your balance once we receive your deposit."
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
}

extension ManualBankDetailVC{
    private func getManualBankDetail(){
        startAnimation(view: self.view)
        let currencyID = self.currencyData?.currency?.id
        let url = manualBankListUrl + "\(currencyID ?? 0)"
        APIDataManager.shared.getData(url:url, param:[:]) { (result:ResultSet< ManualBankListResponseModel,ServerError>) in
            switch result{
            case .success(let data):
                defer{
                    stopAnimation(view: self.view)
                }
                print(data)
                self.bankData = data.data
                DispatchQueue.main.async {
                    if data.status ?? false {
                        self.setUI()
                    }else{
                        self.setAlert(message: data.message ?? "")
                    }
                }
            case .failure(let error):
                stopAnimation(view: self.view)
                let error = error.getErrorMessage()
                self.setAlert(message:error)
            }
        }
    }
    
    private func manualBankAddMoneyAPI(){
        startAnimation(view: self.view)
        let url = "\(addMoneyManualBank )\(self.currencyData?.wuid ?? "")"
        let customReferenceID = generateCustomReferenceID()
        let param:[String:Any] = [
            "ref_id": self.referenceLabel.text ?? "",
            "payee_name": self.payeeNameLabel.text ?? "",
            "sort_code": self.sortCodeLabel.text ?? "",
            "account_no": self.accountNumberLabel.text ?? "",
            "bank_name": self.bankNameLabel.text ?? "",
            "bank_address": self.bankAddressLabel.text ?? "" ,
            "amount": self.amountAdded ?? ""
        ]
        
        print(url, param)
        
        APIDataManager.shared.postData(url:url, param:param) { (result:ResultSet< ManualBankAddMoneyResponseModel,ServerError>) in
            switch result{
            case .success(let data):
                defer{
                    stopAnimation(view: self.view)
                }
                print(data)
                DispatchQueue.main.async {
                    self.navigateToView(status: data.status ?? false, message: data.message ?? "", description: data.description ?? "", error:data.message ?? "")
                }
            case .failure(let error):
                stopAnimation(view: self.view)
                let error = error.getErrorMessage()
                self.setAlert(message:error)
            }
        }
    }
    
    func generateRandomAlphabeticCharacters(length: Int) -> String {
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let randomCharacters = (0..<length).map { _ in letters.randomElement()! }
        return String(randomCharacters)
    }
    
    func generateCustomReferenceID() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyMMddHHmm" // Date format: YearMonthDayHourMinute
        
        let currentDate = Date()
        let formattedDate = dateFormatter.string(from: currentDate)
        
        // Generate a random number of length 3 (padded with leading zeros if needed)
        let randomNumber = String(format: "%03d", Int.random(in: 0...999))
        
        // Generate 3 random alphabetic characters
        let randomAlphabets = generateRandomAlphabeticCharacters(length: 3)
        
        let referenceID = formattedDate + randomNumber + randomAlphabets
        return referenceID
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
            vc.fromView = .manualBank
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func setAlert(message:String){
        let popupVC: PopUpViewController = PopUpViewController.instantiateViewController(identifier: .home)
        popupVC.message = message
        popupVC.imageHide = true
        popupVC.callBackAction = {
            self.navigationController?.popViewController(animated: true)
        }
        popupVC.modalPresentationStyle = .overCurrentContext
        popupVC.modalTransitionStyle = .crossDissolve
        self.navigationController?.present(popupVC, animated: true, completion: nil)
    }
    
    func transferMoneyLater() {
        guard let vc = self.navigationController?.viewControllers else { return }
        for controller in vc {
            if controller.isKind(of: DvTabBarController.self) {
                let tabVC = controller as! DvTabBarController
                tabVC.selectedIndex = 1
                self.navigationController?.popToViewController(tabVC, animated: true)
            }
        }
    }
}
