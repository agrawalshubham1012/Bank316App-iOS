

import Foundation
struct ForgotPasswordModel : Codable {
	let status : Bool?
	let message : String?
	let otp : String?
    let otpVerify : OtpTokenModel?
    let description: String?
    
	enum CodingKeys: String, CodingKey {

		case status = "status"
		case message = "message"
		case otp = "otp"
        case otpVerify = "data"
        case description = "description"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try? values.decode(Bool.self, forKey: .status)
		message = try? values.decode(String.self, forKey: .message)
		otp = try? values.decode(String.self, forKey: .otp)
        otpVerify = try? values.decode(OtpTokenModel.self, forKey: .otpVerify)
        description = try? values.decode(String.self, forKey: .description)
	}

}
