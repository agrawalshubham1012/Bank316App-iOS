//
//  CountryListModel.swift
//  Bank 316
//
//  Created by Dhairya on 08/09/23.
//

import Foundation

struct CountryListModel : Codable {
    var status : Bool?
    var message : String?
    var data : CountryRowsModel?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(CountryRowsModel.self, forKey: .data)
    }

}


