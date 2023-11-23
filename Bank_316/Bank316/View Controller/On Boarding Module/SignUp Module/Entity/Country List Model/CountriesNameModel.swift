
import Foundation
struct CountriesNameModel : Codable {
	var id : Int?
	var country_name : String?
	var country_code : String?
	var country_flag : String?
	var status : String?
	var created_at : String?
	var updated_at : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case country_name = "country_name"
		case country_code = "country_code"
		case country_flag = "country_flag"
		case status = "status"
		case created_at = "created_at"
		case updated_at = "updated_at"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		country_name = try values.decodeIfPresent(String.self, forKey: .country_name)
		country_code = try values.decodeIfPresent(String.self, forKey: .country_code)
		country_flag = try values.decodeIfPresent(String.self, forKey: .country_flag)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
	}

}
