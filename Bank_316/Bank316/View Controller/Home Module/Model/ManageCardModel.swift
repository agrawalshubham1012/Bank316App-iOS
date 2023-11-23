//
//  ManageCardModel.swift
//  Bank 316
//
//  Created by Smt MacMini 3 on 16/11/23.
//

import Foundation


struct CardsResponseModel: Codable {
    let status: Bool?
    let message: String?
    let data: CardsDataClass?
}

// MARK: - DataClass
struct CardsDataClass: Codable {
    let cards: [Card]?
}

// MARK: - Card
struct Card: Codable {
    let id: Int?
    let cardNumber, expiryMonth, expiryYear, cvc: String?
    let createdAt, updatedAt: String?
    let clientID: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case cardNumber = "card_number"
        case expiryMonth = "expiry_month"
        case expiryYear = "expiry_year"
        case cvc
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case clientID = "client_id"
    }
}



struct CardsDeleteResponseModel: Codable {
    let status: Bool?
    let message: String?
}
