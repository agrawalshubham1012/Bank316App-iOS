

import Foundation
struct PostCodeModel : Codable {
	let results : [Results]?
	let status : String?

	enum CodingKeys: String, CodingKey {

		case results = "results"
		case status = "status"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		results = try? values.decode([Results].self, forKey: .results)
		status = try? values.decode(String.self, forKey: .status)
	}

}
