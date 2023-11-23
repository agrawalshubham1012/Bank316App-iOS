

import Foundation
struct LoginModel : Codable {
	let status : Bool?
	let message : String?
	let data : LoginClientModel?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case message = "message"
		case data = "data"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try? values.decode(Bool.self, forKey: .status)
		message = try? values.decode(String.self, forKey: .message)
        data = try? values.decode(LoginClientModel.self, forKey: .data)
	}
}

