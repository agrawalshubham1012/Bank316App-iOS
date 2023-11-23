//
//  AddAmountVC.swift
//  Bank 316
//
//  Created by Smt MacMini 3 on 13/11/23.
//

import UIKit

class AddAmountVC: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var totalFeeLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var feeChargesView: UIStackView!
    @IBOutlet var bgView: UIView!
    var paymentType:TransactionMethod?
    var paymentFee:Double?
    var currencyData:Wallet?
    var isAdd:Bool?
    var amountAdded:String?
    var transactionFee:String?
    var cardDetails:Card?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTransactionFeeData()
        self.setUI()
    }
    
    func setUI(){
        self.bgView.clipsToBounds = true
        self.bgView.layer.masksToBounds = true
        self.bgView.backgroundColor = .appGreen
        self.totalAmountLabel.text = "Total amount \(currencyData?.currency?.symbol ?? "£")0"
        self.totalFeeLabel.text = "Total fee \(currencyData?.currency?.symbol ?? "£")0.00"
        self.amountTextField.text = "\(currencyData?.currency?.symbol ?? "£")"
        self.amountTextField.delegate = self
        print(self.currencyData as Any)
        print(cardDetails as Any)
    }
    
    
    
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addMoneyButton(_ sender: UIButton) {
        self.isAdd = true
        if let stringAmount = self.addSubstractMoney() {
            if let doubleAmount = Double(stringAmount) {
                self.amountAdded = trimmText(text: String(doubleAmount))
                self.amountTextField.text = "\(currencyData?.currency?.symbol ?? "£")\(doubleAmount)"
                self.totalAmountLabel.text = "Total amount \(currencyData?.currency?.symbol ?? "£")\(doubleAmount)"
                self.calculateChargeFee(newAmount:stringAmount)
            }
        }
    }
    
    @IBAction func substractMoneyButton(_ sender: UIButton) {
        self.isAdd = false
        if let stringAmount = self.addSubstractMoney() {
            if let doubleAmount = Double(stringAmount) {
                self.amountAdded = trimmText(text: String(doubleAmount))
                self.amountTextField.text = "\(currencyData?.currency?.symbol ?? "£")\(doubleAmount)"
                self.totalAmountLabel.text = "Total amount \(currencyData?.currency?.symbol ?? "£")\(doubleAmount)"
                self.calculateChargeFee(newAmount:stringAmount)
            }
        }
    }
    
    @IBAction func continueButton(_ sender: UIButton) {
        self.setAlert()
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let updatedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        
        if updatedText.count > 8 {
            return false
        }
        
        if updatedText.count == 1 {
            self.totalAmountLabel.text = "Total amount \(currencyData?.currency?.symbol ?? "£")0"
            self.totalFeeLabel.text = "Total fee \(currencyData?.currency?.symbol ?? "£")0.00"
            return true
        }
        
        if updatedText.isEmpty {
            self.amountTextField.text = "\(currencyData?.currency?.symbol ?? "£")"
            return false
            // Return true to allow the text change, or false to prevent it
        }
        self.totalAmountLabel.text = "Total amount \(updatedText)"
        self.amountAdded = trimmText(text: String(updatedText))
        
        let cleanedText = updatedText.trimmingCharacters(in: .whitespacesAndNewlines)
        let newAmount = cleanedText
            .replacingOccurrences(of: "\(currencyData?.currency?.symbol ?? "£")", with: "")
            .replacingOccurrences(of: ",", with: ".")
        self.calculateChargeFee(newAmount:newAmount)
        // Return true to allow the text change, or false to prevent it
        return true
    }
    
    
    //  AddSubtractMoneyAmount
    func addSubstractMoney() -> String?{
        let cleanedText = self.amountTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let amount = cleanedText?
            .replacingOccurrences(of: "\(currencyData?.currency?.symbol ?? "£")", with: "")
            .replacingOccurrences(of: ",", with: ".") ?? "0"
        let double = Double(amount) ?? 0.0
        let intAmount = double
        if isAdd ?? false {
            let decimalCount = intAmount.numberOfDecimalPlaces
            let newAmount = (intAmount) + 1.0
            let afterDecimalCount = newAmount.numberOfDecimalPlaces
            if decimalCount != afterDecimalCount {
                let stringAmount = newAmount.setDecimalCount(count: decimalCount)
                print(stringAmount)
                return stringAmount
            }else{
                let stringAmount = String(newAmount)
                print(stringAmount)
                return stringAmount
            }
            
        }else{
            if intAmount > 1 {
                let decimalCount = intAmount.numberOfDecimalPlaces
                let newAmount = (intAmount) - 1.0
                let afterDecimalCount = newAmount.numberOfDecimalPlaces
                if decimalCount != afterDecimalCount {
                    let stringAmount = newAmount.setDecimalCount(count: decimalCount)
                    print(stringAmount)
                    return stringAmount
                }else{
                    let stringAmount = String(newAmount)
                    print(stringAmount)
                    return stringAmount
                }
            }else{
                return ""
            }
        }
    }
    
    
    
    func trimmText(text:String) -> String{
        let cleanedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        let amount = cleanedText
            .replacingOccurrences(of: "\(currencyData?.currency?.symbol ?? "£")", with: "")
            .replacingOccurrences(of: ",", with: ".")
        
        return amount
    }
    
    
    // Calculate FeeCharge
    func calculateChargeFee(newAmount:String){
        let amount = Double(newAmount) ?? 0.0
        let payFee = (amount * (paymentFee ?? 0.0) * 0.01)
        print(payFee)
        self.transactionFee = String(payFee)
        self.totalFeeLabel.text = "Total fee \(currencyData?.currency?.symbol ?? "£")\(payFee.formatNumberToTwoDecimals())"
    }
    
    
    func setAlert(){
        let cleanedText = self.amountTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let amount = cleanedText?
            .replacingOccurrences(of: "\(currencyData?.currency?.symbol ?? "£")", with: "")
            .replacingOccurrences(of: ",", with: ".") ?? "0"
        let double = Double(amount) ?? 0.0
        if double <= 0 {
            let popupVC: PopUpViewController = PopUpViewController.instantiateViewController(identifier: .home)
            popupVC.message = "Please enter amount"
            popupVC.imageHide = true
            popupVC.modalPresentationStyle = .overCurrentContext
            popupVC.modalTransitionStyle = .crossDissolve
            self.navigationController?.present(popupVC, animated: true, completion: nil)
        }else{
            self.navigateToNextSection()
        }
    }
    
    func navigateToNextSection(){
        let transactionData:TransactionModel = TransactionModel(addedMoney:self.amountAdded ,transactionMethod:self.paymentType ,toWallet:self.currencyData?.currency?.shortName ,totalFee: self.transactionFee,walletID: self.currencyData?.wuid,currencySymbol:self.currencyData?.currency?.symbol ?? "")
        
        if self.paymentType == .easyBank {
            let vc: EasyBankVC = EasyBankVC.instantiateViewController(identifier: .transaction)
            vc.transactionData = transactionData
            self.navigationController?.pushViewController(vc, animated: true)
            return
        }else if self.paymentType == .manualBank{
            let vc: ManualBankDetailVC = ManualBankDetailVC.instantiateViewController(identifier: .transaction)
            vc.amountAdded = self.amountAdded ?? ""
            vc.currencyData = self.currencyData
            self.navigationController?.pushViewController(vc, animated: true)
            return
        }
        
        let vc: ReviewTransactionVC = ReviewTransactionVC.instantiateViewController(identifier: .transaction)
        vc.transactionData = transactionData
        vc.cardDetails = self.cardDetails
        print(transactionData as Any)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


// API Call
extension AddAmountVC {
    private func getTransactionFeeData(){
        startAnimation(view: self.view)
        let paymentType = TransactionMethod(rawValue:self.paymentType?.rawValue ?? "")?.paymentType
        let url = getTransactionFee + (self.currencyData?.wuid ?? "")
        let param = ["amount":"91","paymentType":paymentType ?? ""]
        APIDataManager.shared.postData(url:url, param:param) { (result:ResultSet< TransactionChargeResponseModel,ServerError>) in
            switch result{
            case .success(let data):
                defer{
                    stopAnimation(view: self.view)
                }
                print(data)
                self.paymentFee = data.data?.convenienceChargePercentage
                self.setFeeChargeUI(data: data)
            case .failure(let error):
                stopAnimation(view: self.view)
                let error = error.getErrorMessage()
                self.setAlert(message:error)
            }
        }
    }
    
    func setFeeChargeUI(data:TransactionChargeResponseModel){
        if data.data?.convenienceChargePercentage == 0.0 {
            self.feeChargesView.isHidden = true
        }else{
            self.feeChargesView.isHidden = false
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
}
