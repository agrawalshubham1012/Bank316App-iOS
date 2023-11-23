
import Foundation
struct CountryRowsModel : Codable {
	var count : Int?
	var rows : [CountriesNameModel]?

	enum CodingKeys: String, CodingKey {

		case count = "count"
		case rows = "rows"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		count = try values.decodeIfPresent(Int.self, forKey: .count)
		rows = try values.decodeIfPresent([CountriesNameModel].self, forKey: .rows)
	}

}
