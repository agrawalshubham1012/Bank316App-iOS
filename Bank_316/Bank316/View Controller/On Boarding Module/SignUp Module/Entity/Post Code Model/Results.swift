

import Foundation
struct Results : Codable {
	let address_components : [Address_components]?
	let formatted_address : String?
	let geometry : Geometry?
	let place_id : String?
	let postcode_localities : [String]?
	let types : [String]?

	enum CodingKeys: String, CodingKey {

		case address_components = "address_components"
		case formatted_address = "formatted_address"
		case geometry = "geometry"
		case place_id = "place_id"
		case postcode_localities = "postcode_localities"
		case types = "types"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		address_components = try? values.decode([Address_components].self, forKey: .address_components)
		formatted_address = try? values.decode(String.self, forKey: .formatted_address)
		geometry = try? values.decode(Geometry.self, forKey: .geometry)
		place_id = try? values.decode(String.self, forKey: .place_id)
		postcode_localities = try? values.decode([String].self, forKey: .postcode_localities)
		types = try? values.decode([String].self, forKey: .types)
	}

}
