

import Foundation
struct SignUpOtpModel : Codable {
	let status : Bool?
	let message : String?
	let client : ClientModel?
	let isComplete : Bool?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case message = "message"
		case client = "client"
		case isComplete = "isComplete"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try? values.decode(Bool.self, forKey: .status)
		message = try? values.decode(String.self, forKey: .message)
		client = try? values.decode(ClientModel.self, forKey: .client)
		isComplete = try? values.decode(Bool.self, forKey: .isComplete)
	}

}
