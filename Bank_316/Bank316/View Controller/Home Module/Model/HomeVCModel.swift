//
//  HomeVCModel.swift
//  Bank 316
//
//  Created by Smt MacMini 3 on 04/11/23.
//

import Foundation
import UIKit

//// MARK: - HomePageResponseModel
//struct HomePageResponseModel: Codable {
//    let status: Bool?
//    let message: String?
//    let data: HomePageData?
//}
//
//// MARK: - DataClass
//struct HomePageData: Codable {
//    let profile: Profile?
//    let defaultWallet: Wallet?
//    let currencyWallets: [Wallet]?
//    let customWallets: [CustomWallet]?
//    let transactions: [Transaction]?
//
//    enum CodingKeys: String, CodingKey {
//        case profile
//        case defaultWallet = "default_wallet"
//        case currencyWallets = "currency_wallets"
//        case customWallets = "custom_wallets"
//        case transactions
//    }
//}
//
//// MARK: - Wallet
//struct Wallet: Codable {
//    let id: Int?
//    let wuid: String?
//    let isDefault: Bool?
//    let currency: Currency?
//    let balance: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id, wuid
//        case isDefault = "is_default"
//        case currency, balance
//    }
//}
//
//// MARK: - Currency
//struct Currency: Codable {
//    let id: Int?
//    let title: String?
//    let shortName: String?
//    let symbol: String?
//    let icon: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id, title
//        case shortName = "short_name"
//        case symbol, icon
//    }
//}
//
//
//// MARK: - CustomWallet
//struct CustomWallet: Codable {
//    let id: Int?
//    let wuid, name: String?
//    let imageID: Int?
//    let currency: Currency?
//    let walletImage: String?
//    let balance: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id, wuid, name
//        case imageID = "image_id"
//        case currency
//        case walletImage = "wallet_image"
//        case balance
//    }
//}
//
//// MARK: - Profile
//struct Profile: Codable {
//    let firstName: String?
//    let middleName: String?
//    let lastName, phone, taxResidency: String?
//    let phoneCode: Int?
//    let dateOfBirth, address, email: String?
//    let avatar: String?
//    let docVerifiedAt, emailVerifiedAt: String?
//    let verificationDocImage, verificationDocID: String?
//    let docVerifiedStatus: DocVerification?
//    let addresses: [Address]?
//    let isEmailVerified, isDocVerified: Bool?
//
//    enum CodingKeys: String, CodingKey {
//        case firstName = "first_name"
//        case middleName = "middle_name"
//        case lastName = "last_name"
//        case phone
//        case taxResidency = "tax_residency"
//        case phoneCode = "phone_code"
//        case dateOfBirth = "date_of_birth"
//        case address, email, avatar
//        case docVerifiedAt = "doc_verified_at"
//        case emailVerifiedAt = "email_verified_at"
//        case verificationDocImage = "verification_doc_image"
//        case verificationDocID = "verification_doc_id"
//        case docVerifiedStatus = "doc_verified_status"
//        case addresses
//        case isEmailVerified = "is_email_verified"
//        case isDocVerified = "is_doc_verified"
//    }
//
//    enum DocVerification: String, Codable {
//        case notVerified = "notVerified"
//        case pending = "pending"
//        case verified = "approved"
//    }
//}
//
//// MARK: - Address
//struct Address: Codable {
//    let id: Int?
//    let country, houseNumber, street: String?
//    let apartment, state: String?
//    let city, postalCode, addressType: String?
//    let isPrimary: Bool?
//    let createdAt, updatedAt: String?
//    let clientID: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case id, country
//        case houseNumber = "house_number"
//        case street, apartment, state, city
//        case postalCode = "postal_code"
//        case addressType = "address_type"
//        case isPrimary = "is_primary"
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case clientID = "client_id"
//    }
//}
//
//// MARK: - Transaction
//struct Transaction: Codable {
//    let id: Int?
//    let txnID: String?
//    let txnType: TxnType?
//    let title: Title?
//    let amount: String?
//    let txnFor: TxnFor?
//    let createdAt, closingBalance, otherClosingBalance: String?
//    let currency: String?
//    let currencyIcon: String?
//    let currencySymbol: String?
//    let amountBeforeTxncharge: String?
//    let paymentmethod: Paymentmethod?
//    let paymentstatus: Paymentstatus?
//    let txnChargePercent: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case txnID = "txn_id"
//        case txnType = "txn_type"
//        case title, amount
//        case txnFor = "txn_for"
//        case createdAt = "created_at"
//        case closingBalance = "closing_balance"
//        case otherClosingBalance = "other_closing_balance"
//        case currency
//        case currencyIcon = "currency_icon"
//        case currencySymbol = "currency_symbol"
//        case amountBeforeTxncharge = "amount_before_txncharge"
//        case paymentmethod, paymentstatus
//        case txnChargePercent = "txn_charge_percent"
//    }
//}
//
//enum Paymentmethod: String, Codable {
//    case bank = "bank"
//    case manualBank = "manual-bank"
//    case wallet = "wallet"
//}
//
//enum Paymentstatus: String, Codable {
//    case failed = "Failed"
//    case success = "success"
//}
//
//enum Title: String, Codable {
//    case moneyAddedViaEasyBankTransfer = "Money added via easy bank transfer"
//    case moneyAddedViaManualBankTransfer = "money added via Manual Bank Transfer"
//    case moneySendedViaWallet = "Money sended via wallet"
//}
//
//enum TxnFor: String, Codable {
//    case add = "add"
//    case transfer = "transfer"
//}
//
//enum TxnType: String, Codable {
//    case credit = "Credit"
//    case debit = "Debit"
//}



struct HomePageResponseModel: Codable {
    let status: Bool?
    let message: String?
    let data: HomePageData?
}

// MARK: - DataClass
struct HomePageData: Codable {
    let profile: Profile?
    let defaultWallet: Wallet?
    let currencyWallets: [Wallet]?
    let customWallets: [CustomWallet]?
    let transactions: [Transaction]?
    
    enum CodingKeys: String, CodingKey {
        case profile
        case defaultWallet = "default_wallet"
        case currencyWallets = "currency_wallets"
        case customWallets = "custom_wallets"
        case transactions
    }
    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        
//        profile = try container.decodeIfPresent(Profile.self, forKey: .profile)
//        
//        if let defaultWalletArray = try? container.decodeIfPresent([Wallet].self, forKey: .defaultWallet), let firstWallet = defaultWalletArray.first {
//            defaultWallet = firstWallet
//        } else if let defaultWalletSingle = try? container.decodeIfPresent(Wallet.self, forKey: .defaultWallet) {
//            defaultWallet = defaultWalletSingle
//        } else {
//            defaultWallet = nil
//        }
//        
//        currencyWallets = try container.decodeIfPresent([Wallet].self, forKey: .currencyWallets)
//        customWallets = try container.decodeIfPresent([CustomWallet].self, forKey: .customWallets)
//        transactions = try container.decodeIfPresent([Transaction].self, forKey: .transactions)
//    }
}


// MARK: - Wallet
struct Wallet: Codable {
    let id: Int?
    let wuid: String?
    let isDefault: Bool?
    let currency: Currency?
    let balance: String?
    
    enum CodingKeys: String, CodingKey {
        case id, wuid
        case isDefault = "is_default"
        case currency, balance
    }
}

// MARK: - Currency
struct Currency: Codable {
    let id: Int?
    let title: String?
    let shortName: String?
    let symbol: String?
    let icon: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case shortName = "short_name"
        case symbol, icon
    }
}

// MARK: - CustomWallet
struct CustomWallet: Codable {
    let id: Int?
    let wuid, name: String?
    let imageID: Int?
    let currency: Currency?
    let walletImage: String?
    let balance: String?
    
    enum CodingKeys: String, CodingKey {
        case id, wuid, name
        case imageID = "image_id"
        case currency
        case walletImage = "wallet_image"
        case balance
    }
}

// MARK: - Profile
struct Profile: Codable {
    let firstName: String?
    let middleName: String?
    let lastName, phone, taxResidency: String?
    let phoneCode: Int?
    let dateOfBirth, address, email: String?
    let avatar: String?
    let docVerifiedAt, emailVerifiedAt: String?
    let verificationDocImage, verificationDocID: String?
    let docVerifiedStatus: String?
    let addresses: [Address]?
    let isEmailVerified, isDocVerified: Bool?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case middleName = "middle_name"
        case lastName = "last_name"
        case phone
        case taxResidency = "tax_residency"
        case phoneCode = "phone_code"
        case dateOfBirth = "date_of_birth"
        case address, email, avatar
        case docVerifiedAt = "doc_verified_at"
        case emailVerifiedAt = "email_verified_at"
        case verificationDocImage = "verification_doc_image"
        case verificationDocID = "verification_doc_id"
        case docVerifiedStatus = "doc_verified_status"
        case addresses
        case isEmailVerified = "is_email_verified"
        case isDocVerified = "is_doc_verified"
    }
}

// MARK: - Address
struct Address: Codable {
    let id: Int?
    let country: String?
    let houseNumber: String?
    let street: String?
    let apartment, state: String?
    let city, postalCode, addressType: String?
    let isPrimary: Bool?
    let createdAt, updatedAt: String?
    let clientID: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, country
        case houseNumber = "house_number"
        case street, apartment, state, city
        case postalCode = "postal_code"
        case addressType = "address_type"
        case isPrimary = "is_primary"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case clientID = "client_id"
    }
}

// MARK: - Transaction
struct Transaction: Codable {
    let id: Int?
    let txnID: String?
    let txnType: String?
    let title, amount: String?
    let txnFor: String?
    let createdAt, closingBalance, otherClosingBalance: String?
    let currency: String?
    let currencyIcon: String?
    let currencySymbol: String?
    let amountBeforeTxncharge, paymentmethod: String?
    let paymentstatus: String?
    let txnChargePercent: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case txnID = "txn_id"
        case txnType = "txn_type"
        case title, amount
        case txnFor = "txn_for"
        case createdAt = "created_at"
        case closingBalance = "closing_balance"
        case otherClosingBalance = "other_closing_balance"
        case currency
        case currencyIcon = "currency_icon"
        case currencySymbol = "currency_symbol"
        case amountBeforeTxncharge = "amount_before_txncharge"
        case paymentmethod, paymentstatus
        case txnChargePercent = "txn_charge_percent"
    }
}

enum TxnFor: String, Codable {
    case add = "add"
    case received = "Received"
    case transfer = "transfer"
    case moved = "Moved"
    case sent = "Sent"
}


struct EarningModel{
    var image: String?
    var title: String?
    var currency: String?
    var percentage: String?
    var color:UIColor?
}

struct CurrencyWallet {
    var currencyWalletName:String?
    var balance:String?
    var symbol:String?
}






// MARK: - TransactionResponseModel
struct TransactionResponseModel: Codable {
    let status: Status?
    let message: String?
    let data: TransactionData?
}

enum Status: Codable {
    case boolValue(Bool)
    case stringValue(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let boolValue = try? container.decode(Bool.self) {
            self = .boolValue(boolValue)
        } else if let stringValue = try? container.decode(String.self) {
            self = .stringValue(stringValue)
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid status value")
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .boolValue(let boolValue):
            try container.encode(boolValue)
        case .stringValue(let stringValue):
            try container.encode(stringValue)
        }
    }
}


// MARK: - DataClass
struct TransactionData: Codable {
    let count: Int?
    let rows: [Row]?
    let totalPages, currentPage: Int?
}

// MARK: - Row
struct Row: Codable {
    let id: Int?
    let title, txnID: String?
    let txnType: String?
    let amount: String?
    let txnFor: String?
    let transactionPercentage, transactionFee: String?
    let identifier: String?
    let transactionChargeType: String?
    let paymentMethod: String?
    let paymentStatus: String?
    let closingBalance: String?
    let currencyConversion: Bool?
    let currency: String?
    let currencyIcon: String?
    let currencySymbol: String?
    let createdAt, updatedAt: String?
    let sender, recipient: Recipient?
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case txnID = "txn_id"
        case txnType = "txn_type"
        case amount
        case txnFor = "txn_for"
        case transactionPercentage = "transaction_percentage"
        case transactionFee = "transaction_fee"
        case identifier
        case transactionChargeType = "transaction_charge_type"
        case paymentMethod = "payment_method"
        case paymentStatus = "payment_status"
        case closingBalance = "closing_balance"
        case currencyConversion = "currency_conversion"
        case currency
        case currencyIcon = "currency_icon"
        case currencySymbol = "currency_symbol"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case sender, recipient
    }
}

// MARK: - Recipient
struct Recipient: Codable {
    let id: Int?
    let name: String?
    let avatar: String?
    let phone: String?
    let email: String?
}

enum BuisnessToolType:String{
    case startSelling = "https://316startups.com"
    case collectPayments = "https://www.316paytech.com"
    case buisnessTools = "https://www.316startups.com/business/fulfilment"
}


