//
//  AddAmountModel.swift
//  Bank 316
//
//  Created by Smt MacMini 3 on 13/11/23.
//

import Foundation


// MARK: - TransactionChargeResponseModel
struct TransactionChargeResponseModel: Codable {
    let status: Bool?
    let message: String?
    let data: TransactionCharge?
}

// MARK: - DataClass
struct TransactionCharge: Codable {
    let amount: String?
    let convenienceChargePercentage,convenienceFee: Double?
    let balanceWithCharge: Charge?
    
    
    enum Charge: Codable {
        case doubleValue(Double)
        case stringValue(String)
        
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let doubleValue = try? container.decode(Double.self) {
                self = .doubleValue(doubleValue)
            } else if let stringValue = try? container.decode(String.self) {
                self = .stringValue(stringValue)
            } else {
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid status value")
            }
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .doubleValue(let doubleValue):
                try container.encode(doubleValue)
            case .stringValue(let stringValue):
                try container.encode(stringValue)
            }
        }
    }

    enum CodingKeys: String, CodingKey {
        case amount
        case convenienceChargePercentage = "convenience_charge_percentage"
        case convenienceFee = "convenience_fee"
        case balanceWithCharge = "balance_with_charge"
    }
}


// MARK: - TransactionChargeRequestModel
struct TransactionChargeRequestModel: Codable {
    let amount, paymentType: String?
}



