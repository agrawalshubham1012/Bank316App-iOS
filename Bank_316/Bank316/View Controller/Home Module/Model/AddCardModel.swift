//
//  AddCardModel.swift
//  Bank 316
//
//  Created by Smt MacMini 3 on 18/11/23.
//

import Foundation

// MARK: - AddCardResponseModel
struct AddCardResponseModel: Codable {
    let status: Bool?
    let message: String?
    let data: AddCardDataClass?
}

// MARK: - DataClass
struct AddCardDataClass: Codable {
    let clientID: Int?
    let cardNumber: String?
    let expiryMonth, expiryYear, cvc: Int?

    enum CodingKeys: String, CodingKey {
        case clientID = "client_id"
        case cardNumber = "card_number"
        case expiryMonth = "expiry_month"
        case expiryYear = "expiry_year"
        case cvc
    }
}
