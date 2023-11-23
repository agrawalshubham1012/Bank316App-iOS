//
//  UITextField + Extension.swift
//  TrainingAmigo
//
//  Created by Dhairya on 27/06/23.
//  Copyright © 2023 Tudip Technologies. All rights reserved.
//

import Foundation
import UIKit
import UIKit.UITextField

//MARK: - Disable Copy, Paste, Select, SelectAll option
class NoCopyPasteTextField: UITextField {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        // Disable copy/paste actions
        if action == #selector(UIResponderStandardEditActions.copy(_:)) ||
            action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }
        
        if action == #selector(UIResponderStandardEditActions.select(_:)) ||
            action == #selector(UIResponderStandardEditActions.selectAll(_:)) {
            return false
        }
        
        // Enable all other actions
        return super.canPerformAction(action, withSender: sender)
    }
}

class StopPasteAction: UITextField {
   open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
}

extension UITextField{
    func validatedText(validationType: ValidatorType) throws -> String {
        let validator = ValidatorFactory.validatorFor(type: validationType)
        return try validator.validated(self.text!)
    }
}

extension Double {
    func formatNumberToTwoDecimals() -> String {
        return String(format: "%.2f", self)
    }
    var numberOfDecimalPlaces: Int {
        let decimalSeparator = Locale.current.decimalSeparator ?? "."
        guard let decimalIndex = String(self).firstIndex(of: Character(decimalSeparator)) else {
            return 0
        }
        return String(self).distance(from: decimalIndex, to: String(self).endIndex) - 1
    }
    
    func setDecimalCount(count:Int) -> String{
        return String(format: "%.\(count)f", self)
    }
}

extension String {
    func hideDigits() -> String {
        return String(repeating: "•", count: count)
    }
}
