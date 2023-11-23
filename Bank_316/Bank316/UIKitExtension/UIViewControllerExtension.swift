//
//  UIViewControllerExtension.swift
//  TrainingAmigo
//
//  Created by chauhan vipul on 06/01/23.
//  Copyright © 2023 Tudip Technologies. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    enum Storyboard: String {
        case login = "Login"
        case splash = "Splash"
        case signUp = "SignUp"
        case forgotPassword = "ForgotPassword"
        case verification = "Verification"
        case home = "Home"
        case popUp = "AlertPopUp"
        case transaction = "Transaction"
    }
    
    
    class func instantiateViewController<T: UIViewController>(identifier : Storyboard) -> T {
        let storyboard =  UIStoryboard(name: identifier.rawValue, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: self)) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.self) ")
        }
        return viewController
    }
}
