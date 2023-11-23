//
//  EasyBankModel.swift
//  Bank 316
//
//  Created by Smt MacMini 3 on 20/11/23.
//

import Foundation

// MARK: - BankListResponseModel
struct BankListResponseModel: Codable {
    let status: Bool?
    let message: String?
    let data: BankListDataClass?
}

// MARK: - DataClass
struct BankListDataClass: Codable {
    let testBanks: [TestBank]?
}

// MARK: - TestBank
struct TestBank: Codable {
    let id, name, type, country: String?
    let parentRef, bankRef: String?
    let isBeta, isTest: Bool?
    let accountTypes: [AccountType]?
    let iconURL: String?
    let userTypes: [String]?
    let transactionHistory: TransactionHistory?
    let status: AvaialbilityStatus?
    let accountDetails: [AccountDetail]?
    let friendlyName: String?
    let connectionGroups: [String]?
    let payments: [String]?

    enum CodingKeys: String, CodingKey {
        case id, name, type, country, parentRef, bankRef, isBeta, isTest, accountTypes
        case iconURL = "iconUrl"
        case userTypes, transactionHistory, status, accountDetails, friendlyName, connectionGroups, payments
    }
}

enum AccountDetail: String, Codable {
    case accounts = "accounts"
    case balances = "balances"
    case standingOrders = "standing_orders"
    case transactions = "transactions"
}

// MARK: - AccountType
struct AccountType: Codable {
    let name: String?
    let beta: Bool?
}

// MARK: - Status
struct AvaialbilityStatus: Codable {
    let sync, auth: String?
}

// MARK: - TransactionHistory
struct TransactionHistory: Codable {
    let monthsInitialConsent, months: Int?
    let description: String?
}


// MARK: - AddMoneyHubResponseModel
struct EasyBankHubResponseModel: Codable {
    let status: Bool?
    let message: String?
    let data: AddMoneyHubData?
}

// MARK: - DataClass
struct AddMoneyHubData: Codable {
    let url: String?
}


// MARK: - AddMoneyHubResponseModel
struct EasyBankWebTransactionResponseModel: Codable {
    let status: Bool?
    let message: String?
    let description: String?
}
