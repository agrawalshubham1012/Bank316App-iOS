//
//  File.swift
//  Bank 316
//
//  Created by Smt MacMini 3 on 17/11/23.
//

import Foundation

//
//// MARK: - CardsResponseModel
//struct AddMoneyCardResponseModel: Codable {
//    let status: Bool?
//    let message, description: String?
//    let data: AddMoneyCardDataClass?
//}
//
//// MARK: - DataClass
//struct AddMoneyCardDataClass: Codable {
//    let createdAt, updatedAt, identifier: String?
//    let currencyConversion: Bool?
//    let reasonName, referenceID: String?
//    let id: Int?
//    let txnID, paymentStatus: String?
//    let txnChargeAmount: Int?
//    let txnChargeType: String?
//    let amount, otherAmount, amountBeforeTxncharge: Int?
//    let txnChargePercent: Double?
//    let paymentMethod, txnType, txnFor: String?
//    let clientID, otherClientID, currencyWalletID: Int?
//    let title: String?
//    let otherWalletID: Int?
//    let closingBalance, otherClosingBalance: Double?
//
//    enum CodingKeys: String, CodingKey {
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case identifier
//        case currencyConversion = "currency_conversion"
//        case reasonName = "reason_name"
//        case referenceID = "reference_id"
//        case id
//        case txnID = "txn_id"
//        case paymentStatus = "payment_status"
//        case txnChargeAmount = "txn_charge_amount"
//        case txnChargeType = "txn_charge_type"
//        case amount
//        case otherAmount = "other_amount"
//        case amountBeforeTxncharge = "amount_before_txncharge"
//        case txnChargePercent = "txn_charge_percent"
//        case paymentMethod = "payment_method"
//        case txnType = "txn_type"
//        case txnFor = "txn_for"
//        case clientID = "client_id"
//        case otherClientID = "other_client_id"
//        case currencyWalletID = "currency_wallet_id"
//        case title
//        case otherWalletID = "other_wallet_id"
//        case closingBalance = "closing_balance"
//        case otherClosingBalance = "other_closing_balance"
//    }
//}



// MARK: - AddMoneyCardResponseModel
struct AddMoneyCardResponseModel: Codable {
    let status: Bool?
    let message, description: String?
    let data: AddMoneyCardDataClass?
}

// MARK: - DataClass
struct AddMoneyCardDataClass: Codable {
    let createdAt, updatedAt, identifier: String?
    let currencyConversion: Bool?
    let reasonName, referenceID: String?
    let id: Int?
    let txnID, paymentStatus: String?
    let txnChargeAmount: Double?
    let txnChargeType: String?
    let amount, otherAmount, amountBeforeTxncharge, txnChargePercent: Double?
    let paymentMethod, txnType, txnFor: String?
    let clientID, otherClientID, currencyWalletID: Int?
    let title: String?
    let otherWalletID: Int?
    let closingBalance, otherClosingBalance: Double?

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case identifier
        case currencyConversion = "currency_conversion"
        case reasonName = "reason_name"
        case referenceID = "reference_id"
        case id
        case txnID = "txn_id"
        case paymentStatus = "payment_status"
        case txnChargeAmount = "txn_charge_amount"
        case txnChargeType = "txn_charge_type"
        case amount
        case otherAmount = "other_amount"
        case amountBeforeTxncharge = "amount_before_txncharge"
        case txnChargePercent = "txn_charge_percent"
        case paymentMethod = "payment_method"
        case txnType = "txn_type"
        case txnFor = "txn_for"
        case clientID = "client_id"
        case otherClientID = "other_client_id"
        case currencyWalletID = "currency_wallet_id"
        case title
        case otherWalletID = "other_wallet_id"
        case closingBalance = "closing_balance"
        case otherClosingBalance = "other_closing_balance"
    }
}

