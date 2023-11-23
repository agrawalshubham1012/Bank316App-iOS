

import Foundation
struct OtpTokenModel : Codable {
	let token : String?

	enum CodingKeys: String, CodingKey {
		case token = "token"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		token = try? values.decode(String.self, forKey: .token)
	}

}
