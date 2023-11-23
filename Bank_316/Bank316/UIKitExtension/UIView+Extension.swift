//
//  UIView+Extension.swift
//  TrainingAmigo
//
//  Created by Dhairya on 16/01/23.
//  Copyright © 2023 Tudip Technologies. All rights reserved.
//
import Foundation
import UIKit
import SDWebImage
// MARK: - UIView -

extension UIView{
    //MARK: - Inspectable Properties
    
    @IBInspectable
    var cornerRadiusData: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderColorData: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var borderWidthData: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            
            layer.borderWidth = newValue
        }
    }
    @IBInspectable
    var opacityData: Float{
        get{
            return layer.opacity
        }
        set{
            layer.opacity = newValue
        }
    }

}

extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}
extension UITextField {

    /// Runtime key
    private struct AssociatedKeys {
        /// max lenght key
        static var maxlength: UInt8 = 0
        /// temp string key
        static var tempString: UInt8 = 0
    }

    /// Limit the maximum input length of the textfiled
    @IBInspectable var maxLength: Int {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.maxlength) as? Int ?? 0
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.maxlength, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            addTarget(self, action: #selector(handleEditingChanged(textField:)), for: .editingChanged)
        }
    }

    /// temp string
    private var tempString: String? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.tempString) as? String
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.tempString, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    /// When the text changes, process the amount of text in the input box so that its length is within the controllable range.
    @objc private func handleEditingChanged(textField: UITextField) {

        /// Special Processing for Chinese Input Method
        guard markedTextRange == nil else { return }

        if textField.text?.count == maxLength {

            /// SET lastQualifiedString where text length == max lenght
            tempString = textField.text
        } else if textField.text?.count ?? 0 < maxLength {

            /// clear lastQualifiedString when text lengeht > maxlength
            tempString = nil
        }

        /// keep current text range in arcgives
        let archivesEditRange: UITextRange?

        if textField.text?.count ?? 0 > maxLength {

            /// if text length > maxlength,remove last range,to move to -1 postion.
            let position = textField.position(from: safeTextPosition(selectedTextRange?.start), offset: -1) ?? textField.endOfDocument
            archivesEditRange = textField.textRange(from: safeTextPosition(position), to: safeTextPosition(position))
        } else {

            /// just set current select text range
            archivesEditRange = selectedTextRange
        }

        /// main handle string max length
        textField.text = tempString ?? String((textField.text ?? "").prefix(maxLength))

        /// last config edit text range
        textField.selectedTextRange = archivesEditRange
    }

    /// get safe textPosition
    private func safeTextPosition(_ optionlTextPosition: UITextPosition?) -> UITextPosition {

        /* beginningOfDocument -> The end of the the text document. */
        return optionlTextPosition ?? endOfDocument
    }
}
//
extension UIView {
    public func addgradientColor(view : UIView,color1: UIColor,color2:UIColor){
        let gradient = CAGradientLayer()
        
        gradient.frame = view.bounds
        
        gradient.colors = [color1.cgColor, color2.cgColor]
        
        gradient.masksToBounds = true
        
        view.layer.insertSublayer(gradient, at: 0)
        
    }
    
    public func setRoundedManualTopCorners(cornerRadius: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        layer.masksToBounds = true
        
    }
    
    public func setRoundedManualbottomCorners(cornerRadius: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = [.layerMaxXMaxYCorner , .layerMinXMaxYCorner]
        layer.masksToBounds = true
        
    }
    
    public func setRoundedManualRightCorners(cornerRadius: CGFloat){
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = [.layerMaxXMinYCorner , .layerMaxXMaxYCorner]
        layer.masksToBounds = true
    }
    
    public func setRoundedManualLeftCorners(cornerRadius: CGFloat){
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = [.layerMinXMinYCorner , .layerMinXMaxYCorner]
        layer.masksToBounds = true
    }
    
}

extension UIView {
    func addTopShadow(color: UIColor = .black, opacity: Float = 0.5, offset: CGSize = CGSize(width: 0, height: -5), radius: CGFloat = 5) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        
        let shadowPath = UIBezierPath(rect: CGRect(x: 0, y: -layer.shadowRadius, width: bounds.width, height: bounds.height + layer.shadowRadius))
        layer.shadowPath = shadowPath.cgPath
    }
}

extension UIImageView {
    
    func sd_setImageCustom(url:String,placeHolderImage:UIImage? = nil,complation : ((UIImage?)->())? = nil) {
        
        if let url = URL(string: url) {
            let indicator : SDWebImageActivityIndicator = SDWebImageActivityIndicator.gray
            indicator.indicatorView.color = .gray
            self.sd_imageIndicator = indicator//SDWebImageActivityIndicator.gray
            self.sd_setImage(with: url, placeholderImage: placeHolderImage, options: .transformAnimatedImage) { (image, error, catchImage, url) in
                if let error = error {
                    print("Image URL : ",String(describing: url))
                    print("SDError : ",error)
                    ez.runThisInMainThread {
                        self.image = placeHolderImage
                        complation?(nil)
                    }
                    return
                }
                
                guard let image = image else {
                    ez.runThisInMainThread {
                        self.image = placeHolderImage
                        complation?(nil)
                    }
                    return
                }
                
                ez.runThisInMainThread {
                    self.image = image
                    complation?(image)
                }
            }
        }else {
            ez.runThisInMainThread {
                self.image = placeHolderImage
                complation?(nil)
            }
        }
    }
}

extension UIView{
    
    private struct AssociatedKeys {
        static var activityIndicator = "view.activityIndicator"
        static var orignalTitle = "view.orignalTitle"
        static var orignalImage = "view.orignalImage"
    }
    
    var isActivityIndicatorRunning : Bool  {
        return self.activitySpinner.isAnimating
    }
    
    
    private func setupActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .red
        activityIndicator.isUserInteractionEnabled = false
        self.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator, attribute: .centerX, multiplier: 1, constant: 0)
        self.addConstraint(xCenterConstraint)

        let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraint(yCenterConstraint)
       
        activityIndicator.center = self.center
        
        self.activitySpinner = activityIndicator
        return activityIndicator
    }
    
    private var orignalTitle : String? {
        
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.orignalTitle) as? String
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.orignalTitle, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    private var orignalImage : UIImage? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.orignalImage) as? UIImage
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.orignalImage, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }

     private var activitySpinner : UIActivityIndicatorView {
        get {
            if let indicator = objc_getAssociatedObject(self, &AssociatedKeys.activityIndicator) as? UIActivityIndicatorView {
                self.bringSubviewToFront(indicator)
                return indicator
            }else{
                
                let indicator = self.setupActivityIndicator()
                self.bringSubviewToFront(indicator)
                return indicator
            }
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.activityIndicator, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func showSpinner(color:UIColor?) {
        var activityColor : UIColor = .black
        if let color = color {
            activityColor = color
        }
        DispatchQueue.main.async {
            if let button = self as? UIButton {
                if let title = button.title(for: .normal),!title.isBlank {
                    self.orignalTitle = title
                }
                if let image = button.image(for: .normal) {
                    self.orignalImage = image
                }
                button.setImage(nil, for: .normal)
                button.setTitle("", for: .normal)
            }
            if let lable = self as? UILabel,let text = lable.text,!text.isBlank {
                self.orignalTitle = lable.text
                lable.text = ""
            }
            self.activitySpinner.color = activityColor
            self.activitySpinner.startAnimating()
        }
    }
    
    func hideSpinner() {
        DispatchQueue.main.async {
            self.activitySpinner.stopAnimating()
            let strTitle = self.orignalTitle
            if let button = self as? UIButton {
                if let img = self.orignalImage {
                    button.setImage(img, for: .normal)
                }
                if let str = self.orignalTitle {
                    button.setTitle(str, for: .normal)
                }
            }else if let lable = self as? UILabel {
                if let title = self.orignalTitle {
                    lable.text = title
                }
            }
        }
    }
}

extension String{
    var isBlank: Bool {
        let trimmed = trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty
    }
}

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}



