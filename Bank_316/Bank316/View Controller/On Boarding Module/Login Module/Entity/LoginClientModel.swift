
import Foundation
struct LoginClientModel : Codable {
	let id : Int?
	let first_name : String?
	let middle_name : String?
	let last_name : String?
	let phone : String?
	let phone_code : Int?
	let date_of_birth : String?
	let address : String?
	let email : String?
	let email_verified_at : String?
	let country_of_residence : String?
	let otp : Int?
	let avatar : String?
	let verification_doc_id : String?
	let verification_doc_image : String?
	let doc_verified_at : String?
	let parent_id : String?
	let referral_code : String?
	let otp_time : String?
	let citizenship_country : String?
	let tax_residency : String?
	let created_at : String?
	let updated_at : String?
	let deleted_at : String?
	let token : String?
	let isComplete : Bool?
	let is_email_verified : Bool?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case first_name = "first_name"
		case middle_name = "middle_name"
		case last_name = "last_name"
		case phone = "phone"
		case phone_code = "phone_code"
		case date_of_birth = "date_of_birth"
		case address = "address"
		case email = "email"
		case email_verified_at = "email_verified_at"
		case country_of_residence = "country_of_residence"
		case otp = "otp"
		case avatar = "avatar"
		case verification_doc_id = "verification_doc_id"
		case verification_doc_image = "verification_doc_image"
		case doc_verified_at = "doc_verified_at"
		case parent_id = "parent_id"
		case referral_code = "referral_code"
		case otp_time = "otp_time"
		case citizenship_country = "citizenship_country"
		case tax_residency = "tax_residency"
		case created_at = "created_at"
		case updated_at = "updated_at"
		case deleted_at = "deleted_at"
		case token = "token"
		case isComplete = "isComplete"
		case is_email_verified = "is_email_verified"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try? values.decode(Int.self, forKey: .id)
		first_name = try? values.decode(String.self, forKey: .first_name)
		middle_name = try? values.decode(String.self, forKey: .middle_name)
		last_name = try? values.decode(String.self, forKey: .last_name)
		phone = try? values.decode(String.self, forKey: .phone)
		phone_code = try? values.decode(Int.self, forKey: .phone_code)
		date_of_birth = try? values.decode(String.self, forKey: .date_of_birth)
		address = try? values.decode(String.self, forKey: .address)
		email = try? values.decode(String.self, forKey: .email)
		email_verified_at = try? values.decode(String.self, forKey: .email_verified_at)
		country_of_residence = try? values.decode(String.self, forKey: .country_of_residence)
		otp = try? values.decode(Int.self, forKey: .otp)
		avatar = try? values.decode(String.self, forKey: .avatar)
		verification_doc_id = try? values.decode(String.self, forKey: .verification_doc_id)
		verification_doc_image = try? values.decode(String.self, forKey: .verification_doc_image)
		doc_verified_at = try? values.decode(String.self, forKey: .doc_verified_at)
		parent_id = try? values.decode(String.self, forKey: .parent_id)
		referral_code = try? values.decode(String.self, forKey: .referral_code)
		otp_time = try? values.decode(String.self, forKey: .otp_time)
		citizenship_country = try? values.decode(String.self, forKey: .citizenship_country)
		tax_residency = try? values.decode(String.self, forKey: .tax_residency)
		created_at = try? values.decode(String.self, forKey: .created_at)
		updated_at = try? values.decode(String.self, forKey: .updated_at)
		deleted_at = try? values.decode(String.self, forKey: .deleted_at)
		token = try? values.decode(String.self, forKey: .token)
		isComplete = try? values.decode(Bool.self, forKey: .isComplete)
		is_email_verified = try? values.decode(Bool.self, forKey: .is_email_verified)
	}

}
