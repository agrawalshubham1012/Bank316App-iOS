//
//  ReviewTransactionModel.swift
//  Bank 316
//
//  Created by Smt MacMini 3 on 14/11/23.
//

import Foundation

struct TransactionModel{
    var addedMoney:String?
    var transactionMethod:TransactionMethod?
    var toWallet:String?
    var totalFee:String?
    var walletID:String?
    var currencySymbol:String
}

enum TransactionMethod:String{
    case googlePay
    case card
    case easyBank
    case manualBank
    
    var title:String{
        switch self {
        case .googlePay :
            return "Google Pay"
        case .card :
            return "Card Payment"
        case .easyBank:
            return "Easy Bank"
        case .manualBank:
            return "Manual Bank"
        }
    }
    
    var paymentType:String{
        switch self {
        case .googlePay :
            return "google-pay"
        case .card :
            return "card"
        case .easyBank:
            return "bank"
        case .manualBank:
            return "bank"
        }
    }
}


enum WalletCode:String{
    case GBP = "GBP"
    case INR = "IMR"
    case XOF = "XOF"
    case EUR = "EUR"
    
    var countryCode:String {
        switch self{
        case .GBP:
            return "GB"
        case .INR:
            return "IN"
        case .XOF:
            return "BF"
        case .EUR :
            return "FR"
        }
    }
}
