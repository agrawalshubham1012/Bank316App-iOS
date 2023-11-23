//
//  Validation.swift
//  Bank 316
//
//  Created by Dhairya on 27/06/22.
//

import Foundation

///Protocol to validate all the possible textfield types
protocol ValidatorConvertible {
    func validated(_ value: String) throws -> String
}

//MARK: - Error handling for wrong Validation
class ValidationError: Error {
    var message: String
    
    init(_ message: String) {
        self.message = message
    }
}

///Enum for validation Type
enum ValidatorType {
    case email
    case password
    case username
    case projectIdentifier
    case requiredField(field: String)
    case age
}

///Enum function for validator factory
enum ValidatorFactory {
    static func validatorFor(type: ValidatorType) -> ValidatorConvertible {
        switch type {
        case .email: return EmailValidator()
        case .password: return PasswordValidator()
        case .username: return UserNameValidator()
        case .projectIdentifier: return ProjectIdentifierValidator()
        case .requiredField(let fieldName): return RequiredFieldValidator(fieldName)
        case .age: return AgeValidator()
        }
    }
}

//MARK: - project Identifier validator with all the possible cases
struct ProjectIdentifierValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        do {
            if try NSRegularExpression(pattern: "^[A-Z]{1}[0-9]{1}[-]{1}[0-9]{3}[A-Z]$",  options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Invalid Project Identifier Format")
            }
        } catch {
            throw ValidationError("Invalid Project Identifier Format")
        }
        return value
        
    }
}

//MARK: - Age validator with all the possible cases
class AgeValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count > 0 else {throw ValidationError("Age is required")}
        guard let age = Int(value) else {throw ValidationError("Age must be a number!")}
        guard value.count < 3 else {throw ValidationError("Invalid age number!")}
        guard age >= 18 else {throw ValidationError("You have to be over 18 years old to user our app :)")}
        return value
    }
}

//MARK: - Textfield Validator for empty text
struct RequiredFieldValidator: ValidatorConvertible {
    private let fieldName: String
    
    init(_ field: String) {
        fieldName = field
    }
    
    func validated(_ value: String) throws -> String {
        guard !value.isEmpty else {
            throw ValidationError("Required field " + fieldName)
        }
        return value
    }
}

//MARK: - User name Validator with all the possible cases
struct UserNameValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count >= 3 else {
            throw ValidationError("Username must contain more than three characters" )
        }
        guard value.count < 40 else {
            throw ValidationError("Username shoudn't conain more than 40 characters" )
        }
        
        do {
            if try NSRegularExpression(pattern: "^[a-z]{1,18}$",  options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Invalid username, username should not contain whitespaces, numbers or special characters")
            }
        } catch {
            throw ValidationError("Invalid username, username should not contain whitespaces,  or special characters")
        }
        return value
    }
}

//MARK: - Password Validator with all the possible cases
struct PasswordValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value != "" else {throw ValidationError("Password is Required")}
        guard value.count >= 8 else { throw ValidationError("Password must have at least 8 characters") }
        
        return value
    }
}

//MARK: - EmailID Validator with all the possible cases
struct EmailValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        do {
            if try NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Invalid e-mail Address")
            }
        } catch {
            throw ValidationError("Invalid e-mail Address")
        }
        return value
    }
}



