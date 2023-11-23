
import Foundation
struct Viewport : Codable {
	let northeast : Northeast?
	let southwest : Southwest?

	enum CodingKeys: String, CodingKey {

		case northeast = "northeast"
		case southwest = "southwest"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		northeast = try? values.decode(Northeast.self, forKey: .northeast)
		southwest = try? values.decode(Southwest.self, forKey: .southwest)
	}

}
