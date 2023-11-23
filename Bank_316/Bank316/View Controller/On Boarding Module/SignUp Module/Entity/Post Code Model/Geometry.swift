

import Foundation
struct Geometry : Codable {
	let bounds : Bounds?
	let location : Location?
	let location_type : String?
	let viewport : Viewport?

	enum CodingKeys: String, CodingKey {

		case bounds = "bounds"
		case location = "location"
		case location_type = "location_type"
		case viewport = "viewport"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		bounds = try? values.decode(Bounds.self, forKey: .bounds)
		location = try? values.decode(Location.self, forKey: .location)
		location_type = try? values.decode(String.self, forKey: .location_type)
		viewport = try? values.decode(Viewport.self, forKey: .viewport)
	}

}
