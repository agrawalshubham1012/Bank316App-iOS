//
//  Rechability.swift
//  Training Amigo
//
//  Created by Tudip on 14/03/16.
//  Copyright © 2016 Tudip Technologies. All rights reserved.
//

import Foundation
import SystemConfiguration
import UIKit

open class Rechability {
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { zeroStockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroStockAddress)
            }
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
}

protocol NetworkPopViewDelegate {
    func closeNetworkPopup()
}

open class NetworkPopView: UIView {
    
    var delegate = NetworkPopViewDelegate?.self
    let height: CGFloat = 20
    
    let statusBarheight = UIApplication.shared.statusBarFrame.height
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(closeButtonRequired: Bool) {
        let width = UIScreen.main.bounds.width
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: height + statusBarheight))
        backgroundColor = UIColor(red: 76.0/255.0, green: 76.0/255.0, blue: 76.0/255.0, alpha: 1)
        if closeButtonRequired {
            addCloseButton()
        }
    }
    
    open override func draw(_ rect: CGRect) {
        let networkLabel = UILabel(frame: CGRect(x: 0, y: statusBarheight - 8, width: frame.width, height: 20))
        networkLabel.textAlignment = NSTextAlignment.center
        networkLabel.text = "No Internet Connection"
        networkLabel.textColor = UIColor.white
        networkLabel.font = UIFont(name: "HelveticaNeue", size: CGFloat(14))
        addSubview(networkLabel)
        //MARK: - Display view with animation
        self.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: height + statusBarheight)
        UIView.animate(withDuration: 0.9, delay: 0.0, options: .curveEaseOut, animations: {
            self.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.height + self.statusBarheight)
            }, completion: { finished in
                //MARK: - Handle after finish the animation
        })
    }
    
    //MARK: - Add close button to the view
    func addCloseButton() {
        let closeButton = UIButton(frame: CGRect(x: (self.frame.width - 25), y: 17, width: 15, height: 15))
        let image = UIImage(named: "close")
        closeButton.setBackgroundImage(image, for: UIControl.State())
        closeButton.addTarget(self, action: #selector(NetworkPopView.closeButtonTapped), for: UIControl.Event.touchUpInside)
        addSubview(closeButton)
    }
    //MARK: - Close button action
    
    @objc func closeButtonTapped() {
        //delegate?.closeNetworkPopup()
    }
}
