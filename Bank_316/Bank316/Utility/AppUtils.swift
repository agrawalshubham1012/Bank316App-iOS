//
//  AppUtils.swift
//  Bank 316
//
//  Created by Dhairya on 24/08/23.
//

import Foundation
import UIKit

struct ValidateEmailPassword {
    /// Email Validation
    func validateEmail(textField: UITextField?, buttonStatus: UIButton?) -> Bool{
        do{
            let _ = try textField?.validatedText(validationType: .email)
            return true
        }catch{
//            buttonStatus?.isEnabled = false
            return false
        }
    }
    
     /// Password Validation
    func validatePassword(textField: UITextField?) -> Bool{
        do{
            let _ = try textField?.validatedText(validationType: .password)
            return true
        }catch{
//            buttonStatus?.isEnabled = false
            return false
        }
    }
}
