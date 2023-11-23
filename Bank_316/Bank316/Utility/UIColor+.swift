//
//  UIColor+.swift
//  95PlusBaseBall
//
//  Created by MP-15 on 03/08/17.
//  Copyright © 2017 Tudip. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init(hex: UInt32, alpha: CGFloat = 1) {
        let red = CGFloat((hex & 0xFF0000) >> 16)/256.0
        let green = CGFloat((hex & 0xFF00) >> 8)/256.0
        let blue = CGFloat(hex & 0xFF)/256.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    // Convert RGB color to Hex String.
    /**
     - parameter color: The selected UIColor
     
     :return: converted hex string of UIColor
     */
    func convertRGBToHex(_ color: UIColor) -> String {
        var r:CGFloat=0, g:CGFloat=0, b:CGFloat=0, a:CGFloat = 0
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return NSString(format:"#%06x", rgb) as String
    }
}
// get color using hex color code.
func hexStringToUIColor (hex:String, alpha: CGFloat = 1) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: alpha
    )
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    convenience init(netHex:Int, alpha:Double) {
        let red = CGFloat((netHex & 0xFF0000) >> 16)/256.0
        let green = CGFloat((netHex & 0xFF00) >> 8)/256.0
        let blue = CGFloat(netHex & 0xFF)/256.0
        self.init(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
}

