//
//  SelfieModel.swift
//  Bank 316
//
//  Created by Smt MacMini 3 on 04/11/23.
//

import Foundation


// MARK: - EmailVerificationResponseModel
struct SelfieResponseModel: Codable {
    let status: Bool?
    let message, description: String?
    let imageURL: String?

    enum CodingKeys: String, CodingKey {
        case status, message, description
        case imageURL = "image_url"
    }
}


struct FinalVerificationResponseModel: Codable {
    let status: Bool?
    let message:String?

    enum CodingKeys: String, CodingKey {
        case status, message
    }
}
