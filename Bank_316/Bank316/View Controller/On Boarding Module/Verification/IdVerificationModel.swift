//
//  IdVerificationModel.swift
//  Bank 316
//
//  Created by Smt MacMini 3 on 04/11/23.
//

import Foundation
import UIKit
struct IdVerificationResponseModel: Codable {
    let documentURL: String?
        let message: String?
        let status: Bool?
        let description: String?

        enum CodingKeys: String, CodingKey {
            case documentURL = "document_url"
            case message, status, description
        }
}
