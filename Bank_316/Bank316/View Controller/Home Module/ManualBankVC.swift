//
//  ManualBankVC.swift
//  Bank 316
//
//  Created by Smt MacMini 3 on 22/11/23.
//

import UIKit

class ManualBankVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    var amountAdded:String?
    var currencyData:Wallet?
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet var bgView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        
        // Define colors for the gradient layer
        gradientLayer.colors = [UIColor.appGreen, UIColor.white.cgColor]
        
        // Set the locations for the colors (in this case, divide at the midpoint)
        gradientLayer.locations = [0.5]
        
        // Define the start and end points for the gradient
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        
        // Add the gradient layer as the background of your view
        bgView.layer.insertSublayer(gradientLayer, at: 0)
        
        
        
        print(UIScreen.main.bounds.height)
        if UIScreen.main.bounds.height > 850 {
            self.heightConstraint.constant = UIScreen.main.bounds.height *  0.675
            self.scrollView.isScrollEnabled = false
        }

    }
    
    
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func nextButton(_ sender: UIButton) {
        let vc: ConfirmAccountHolderVC = ConfirmAccountHolderVC.instantiateViewController(identifier: .transaction)
        vc.currencyData = self.currencyData
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
 
}
