//
//  ManualBankDetailModel.swift
//  Bank 316
//
//  Created by Smt MacMini 3 on 22/11/23.
//

import Foundation

// MARK: - ManualBankListResponseModel
struct ManualBankListResponseModel: Codable {
    let status: Bool?
    let message: String?
    let data: ManualBankList?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            // Try to decode as single instance
            data = try container.decode(ManualBankList.self, forKey: .data)
        } catch DecodingError.typeMismatch {
            // If decoding as single instance fails, try decoding as an array
            if let arrayData = try? container.decode([ManualBankList].self, forKey: .data) {
                data = arrayData.first
            } else {
                // If decoding as an array also fails, set data to nil
                data = nil
            }
        } catch {
            // Handle any other decoding errors or set data as nil
            data = nil
        }
        
        // Initialize other properties if needed
        status = try container.decodeIfPresent(Bool.self, forKey: .status)
        message = try container.decodeIfPresent(String.self, forKey: .message)
    }
    
}

// MARK: - DataClass
struct ManualBankList: Codable {
    let id: Int?
    let payeeName, sortCode, accountNo, bankName: String?
    let bankAddress, createdAt, updatedAt: String?
    let currencyID: Int?
    let currency: BankCurrency?
    
    enum CodingKeys: String, CodingKey {
        case id
        case payeeName = "payee_name"
        case sortCode = "sort_code"
        case accountNo = "account_no"
        case bankName = "bank_name"
        case bankAddress = "bank_address"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case currencyID = "currency_id"
        case currency
    }
}

// MARK: - Currency
struct BankCurrency: Codable {
    let id: Int?
    let shortName, title: String?
    let icon: String?
    let symbol: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case shortName = "short_name"
        case title, icon, symbol
    }
}


// MARK: - ManualBankAddMoneyResponseModel
struct ManualBankAddMoneyResponseModel: Codable {
    let status: Bool?
    let message, description: String?
    let data: ManualBankAddMoney?
}

// MARK: - DataClass
struct ManualBankAddMoney: Codable {
    let currencyName, currencySymbol, recipientID, accountHolderName: String?
    let ibanNumber, swiftCode, ifscCode, upiID: String?
    let requestIdentity: String?
    let comment, status: String?
    let id: Int?
    let refID, txnID: String?
    let amount: Double?
    let currencyWalletWuid, bankName, accountNo, sortCode: String?
    let otherClientID: Int?
    let otherCurrencyWalletWuid, description: String?
    let clientID: Int?
    let createdDate: String?
    let requiresPermission: Bool?
    let updatedAt, createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case currencyName = "currency_name"
        case currencySymbol = "currency_symbol"
        case recipientID = "recipient_id"
        case accountHolderName = "account_holder_name"
        case ibanNumber = "iban_number"
        case swiftCode = "swift_code"
        case ifscCode = "ifsc_code"
        case upiID = "upi_id"
        case requestIdentity = "request_identity"
        case comment, status, id
        case refID = "ref_id"
        case txnID = "txn_id"
        case amount
        case currencyWalletWuid = "currency_wallet_wuid"
        case bankName = "bank_name"
        case accountNo = "account_no"
        case sortCode = "sort_code"
        case otherClientID = "other_client_id"
        case otherCurrencyWalletWuid = "other_currency_wallet_wuid"
        case description
        case clientID = "client_id"
        case createdDate = "created_date"
        case requiresPermission = "requires_permission"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
    }
}

