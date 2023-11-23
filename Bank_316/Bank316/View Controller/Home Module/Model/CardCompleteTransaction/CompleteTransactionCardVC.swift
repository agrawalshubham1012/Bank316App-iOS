//
//  CompleteTransactionCardVC.swift
//  Bank 316
//
//  Created by Smt MacMini 3 on 16/11/23.
//

import UIKit

class CompleteTransactionCardVC: UIViewController {
    
    @IBOutlet weak var transactionSuccessLabel: UILabel!
    @IBOutlet weak var successHeaderLabel: UILabel!
    
    var apiDescriptions:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
    }
    
    func setUI(){
        self.showCardTransactionResponse()
    }
    
    func showCardTransactionResponse(){
        self.transactionSuccessLabel.text = apiDescriptions ?? ""
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
