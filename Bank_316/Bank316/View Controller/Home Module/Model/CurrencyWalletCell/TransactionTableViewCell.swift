//
//  TransactionTableViewCell.swift
//  Bank 316
//
//  Created by Smt MacMini 3 on 08/11/23.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var transactionIdLabel: UILabel!
    @IBOutlet weak var transactionTimeLabel: UILabel!
    @IBOutlet weak var exchangeMoneyLabel: UILabel!
    @IBOutlet weak var closingBalanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUI(data:Row?){
        setIconImage(data:data)
        if data?.paymentMethod ?? "" == "wallet" {
            self.transactionTimeLabel.text = "\(data?.txnFor ?? ""). \(setTransactionTime(data: data))"
        }else{
            self.transactionTimeLabel.text = "\(data?.paymentMethod ?? ""). \(setTransactionTime(data: data))"
        }
        self.transactionIdLabel.text = data?.title
//        self.exchangeMoneyLabel.text = "\(data?.currencySymbol ?? "")\(data?.amount ?? "")"
        self.closingBalanceLabel.text = "\(data?.currencySymbol ?? "") \(data?.closingBalance ?? "")"
    }
    
    
    func setIconImage(data:Row?){
        switch TxnFor(rawValue: data?.txnFor ?? "") {
        case .add:
            self.imageIcon.image = UIImage(named: "creditedIcon")
            self.exchangeMoneyLabel.textColor = UIColor(red: 90/255, green: 171/255, blue: 78/255, alpha: 1.0)
            self.exchangeMoneyLabel.text = "\(data?.currencySymbol ?? "")\(data?.amount ?? "")"
        case .received:
            self.imageIcon.image = UIImage(named: "creditedIcon")
            self.exchangeMoneyLabel.textColor = UIColor(red: 90/255, green: 171/255, blue: 78/255, alpha: 1.0)
            self.exchangeMoneyLabel.text = "\(data?.currencySymbol ?? "")\(data?.amount ?? "")"
        case .transfer:
            self.imageIcon.image = UIImage(named: "debitedIcon")
            self.exchangeMoneyLabel.textColor = UIColor(red: 247/255, green: 99/255, blue: 100/255, alpha: 1.0)
            self.exchangeMoneyLabel.text = "-\(data?.currencySymbol ?? "")\(data?.amount ?? "")"
        case .moved:
            self.imageIcon.image = UIImage(named: "CustomMoneyIcon")
            self.exchangeMoneyLabel.textColor = UIColor(red: 90/255, green: 171/255, blue: 78/255, alpha: 1.0)
            self.exchangeMoneyLabel.text = "\(data?.currencySymbol ?? "")\(data?.amount ?? "")"
        case .sent:
            self.imageIcon.image = UIImage(named: "debitedIcon")
            self.exchangeMoneyLabel.textColor = UIColor(red: 247/255, green: 99/255, blue: 100/255, alpha: 1.0)
            self.exchangeMoneyLabel.text = "-\(data?.currencySymbol ?? "")\(data?.amount ?? "")"
        default:
            return
        }
    }
    
    
    func setTransactionTime(data: Row?) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: data?.createdAt ?? "")
        print("date: \(date ?? Date())")
        if let dateString = date?.categorizedDateString(){
            return dateString
        }else{
            return ""
        }
    }
}
