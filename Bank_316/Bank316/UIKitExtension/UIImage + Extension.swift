//
//  UIImage + Extension.swift
//  Bank 316
//
//  Created by Smt MacMini 3 on 20/11/23.
//

import Foundation
import UIKit
import StripePaymentsUI


extension UIImage {
    func roundedImage(cornerRadius: CGFloat, corners: UIRectCorner, borderWidth: CGFloat = 0, borderColor: UIColor? = nil) -> UIImage? {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }

        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
        )
        context.addPath(path.cgPath)
        context.clip()

        draw(in: rect)

        if borderWidth > 0 {
            context.setStrokeColor((borderColor ?? UIColor.clear).cgColor)
            context.setLineWidth(borderWidth)
            context.addPath(path.cgPath)
            context.strokePath()
        }

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }
}

extension STPCardBrand {
    func cardBrandImage() -> UIImage? {
        switch self {
        case .amex:
            return STPImageLibrary.amexCardImage()
        case .visa:
            return STPImageLibrary.visaCardImage()
        case .mastercard:
            return STPImageLibrary.mastercardCardImage()
        case .discover:
            return STPImageLibrary.discoverCardImage()
        case .JCB:
            return STPImageLibrary.jcbCardImage()
        case .dinersClub:
            return STPImageLibrary.dinersClubCardImage()
        case .unionPay:
            return STPImageLibrary.unionPayCardImage()
        case .unknown:
            return STPImageLibrary.unknownCardCardImage()
        case .cartesBancaires:
            return STPImageLibrary.unknownCardCardImage()
        @unknown default:
            return UIImage()
        }
    }
}

