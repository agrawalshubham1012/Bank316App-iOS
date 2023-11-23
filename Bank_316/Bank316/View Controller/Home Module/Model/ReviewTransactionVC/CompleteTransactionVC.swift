//
//  CompleteTransactionVC.swift
//  Bank 316
//
//  Created by Smt MacMini 3 on 16/11/23.
//

import UIKit
import StripePaymentsUI

enum ControllerType:String {
    case manualBank
    case cardFlow
    case easyBank
    case applePay
}

class CompleteTransactionVC: UIViewController {
    
    @IBOutlet weak var transactionFlowIcon: UIImageView!
    @IBOutlet weak var successDescriptionLabel: UILabel!
    @IBOutlet weak var successHeaderLabel: UILabel!
    @IBOutlet weak var animatedArrowImage: UIImageView!
    @IBOutlet weak var animatedView: UIView!
    @IBOutlet weak var back316View: UIView!
    var transactionAmount:String?
    var toWallet:String?
    var fromView:ControllerType?
    var headerLabel:String?
    var apiDescription:String?
    var cardNumber:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.back316View.backgroundColor = .white
        self.animatedArrowImage.isHidden = false
        self.setUI()
        self.animatedArrow()
    }
    
    func setUI(){
        switch fromView {
        case .manualBank:
            self.manualBankAttributeText()
        case .cardFlow:
            self.cardTransactionSuceessText()
        case .easyBank:
            self.easyBankWebAttributeText()
        case .applePay:
            self.applePayAttributeText()
        case nil:
            break
        }
    }
    
    func applePayAttributeText(){
        let transactionAmount:String = "\(self.transactionAmount ?? "") \(self.toWallet ?? "")"
        let amountText = "You have added successfully added \(transactionAmount) to your 316 Pound balance."
        let attributedString = NSMutableAttributedString(string: amountText)
        if let range = amountText.range(of: amountText) {
            _ = NSRange(range, in: amountText)
        }
        self.successDescriptionLabel.attributedText = attributedString
        self.successHeaderLabel.text = "Your deposit is complete"
        self.transactionFlowIcon.image = UIImage(named: "GPayTransaction")
    }
    
    func easyBankWebAttributeText(){
        self.successHeaderLabel.text = self.headerLabel
        self.successDescriptionLabel.text = "£\(self.apiDescription ?? "")"
    }
    
    func manualBankAttributeText(){
        self.successHeaderLabel.text = self.headerLabel
        self.successDescriptionLabel.text = "\(self.apiDescription ?? "")"
        self.transactionFlowIcon.image = UIImage(named: "manualBankSuccess")
    }
    
    func cardTransactionSuceessText(){
        self.successHeaderLabel.text = self.headerLabel ?? ""
        self.successDescriptionLabel.text = self.apiDescription ?? ""
        let cardBrand = STPCardValidator.brand(forNumber: cardNumber ?? "")
        let cardBrandImageName = cardBrand.cardBrandImage()
        self.transactionFlowIcon.image = cardBrandImageName
    }
    
    
    @IBAction func continueButton(_ sender: UIButton) {
        guard let vc = self.navigationController?.viewControllers else { return }
        for controller in vc {
            if controller.isKind(of: DvTabBarController.self) {
                let tabVC = controller as! DvTabBarController
                tabVC.selectedIndex = 1
                self.navigationController?.popToViewController(tabVC, animated: true)
            }
        }
    }
}

extension CompleteTransactionVC {
    func animatedArrow() {
        guard let animatedArrowImage = self.animatedArrowImage else { return }
        
        let initialX = 0.0
        let finalX = self.animatedView.bounds.width - animatedArrowImage.frame.width
        
        // Set the initial position to the centered position
        animatedArrowImage.frame.origin.x = initialX
        
        UIView.animate(withDuration: 3.0, delay: 0.0, options: [.curveLinear], animations: {
            animatedArrowImage.frame.origin.x = finalX // Move to the right edge of the view
        }, completion: { _ in
            self.back316View.backgroundColor = .appYellow
            self.animatedArrowImage.isHidden = true
        })
    }

}
