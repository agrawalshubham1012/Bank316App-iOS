//
//  UITextView+Extension.swift
//  TrainingAmigo
//
//  Created by Dhairya on 17/01/23.
//  Copyright © 2023 Tudip Technologies. All rights reserved.
//

import Foundation
import UIKit
// MARK: - UITextView -

extension UITextView{
    
    // MARK: - Class Properties
    private class PlaceholderLabel: UILabel { }
    private var placeholderLabel: PlaceholderLabel {
        
        if let label = subviews.compactMap( { $0 as? PlaceholderLabel }).first {
            return label
        } else {
            var label = PlaceholderLabel(frame: .zero)
            label.font = font
            addSubview(label)
            return label
        }
    }
    
    // -----------------------------------------------------------------------------------------------
    
    // MARK: - PlaceHolder text for textView
    
    @IBInspectable
    var placeholder: String {
        get {
            return subviews.compactMap( { $0 as? PlaceholderLabel }).first?.text ?? ""
        }
        set {
            let placeholderLabel = self.placeholderLabel
            (defaults.string(forKey: "Slogan")?.contains(where: {$0 == "-"}) == true) ? ( placeholderLabel.text = newValue) : ( placeholderLabel.text = defaults.string(forKey: "Slogan"))
            placeholderLabel.numberOfLines = 0
            let width = frame.width - textContainer.lineFragmentPadding * 2
            let size = placeholderLabel.sizeThatFits(CGSize(width: width, height: .greatestFiniteMagnitude))
            
            placeholderLabel.frame.size.height = size.height
            placeholderLabel.frame.size.width = width
            placeholderLabel.frame.origin = CGPoint(x: textContainer.lineFragmentPadding, y: textContainerInset.top)
            placeholderLabel.textColor = .lightGray
            textStorage.delegate = self
        }
    }
}

// MARK: - Storage Usage of TextField
extension UITextView: NSTextStorageDelegate {
    
    public func textStorage(_ textStorage: NSTextStorage, didProcessEditing editedMask: NSTextStorage.EditActions, range editedRange: NSRange, changeInLength delta: Int) {
        if editedMask.contains(.editedCharacters) {
            placeholderLabel.isHidden = !text.isEmpty
            placeholderLabel.textColor = .lightGray
        }
    }
}
