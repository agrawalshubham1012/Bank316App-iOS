//
//  EmailVerficationModel.swift
//  Bank 316
//
//  Created by Smt MacMini 3 on 04/11/23.
//

import Foundation

struct EmailVerificationResponseModel: Codable {
    let status: Bool?
    let message, description: String?
}
