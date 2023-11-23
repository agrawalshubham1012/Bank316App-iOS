
import Foundation
struct Location : Codable {
	let lat : Double?
	let lng : Double?

	enum CodingKeys: String, CodingKey {

		case lat = "lat"
		case lng = "lng"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		lat = try? values.decode(Double.self, forKey: .lat)
		lng = try? values.decode(Double.self, forKey: .lng)
	}

}
