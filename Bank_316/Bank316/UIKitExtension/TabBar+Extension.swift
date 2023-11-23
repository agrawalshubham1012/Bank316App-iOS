//
//  TabBar+Extension.swift
//  Bank 316
//
//  Created by Dhairya on 05/10/23.
//

import Foundation
import UIKit

class CustomTabBar : UITabBar {
    @IBInspectable var height: CGFloat = 0.0

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        if height > 0.0 {
            sizeThatFits.height = height
        }
        return sizeThatFits
    }
}
