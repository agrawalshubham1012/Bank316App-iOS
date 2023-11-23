//
//  FailureTransactionVC.swift
//  Bank 316
//
//  Created by Smt MacMini 3 on 17/11/23.
//

import UIKit

class FailureTransactionVC: UIViewController {
    
    @IBOutlet weak var failureLabel: UILabel!
    @IBOutlet weak var errorDescriptionLabel: UILabel!
    var apiError:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
    }
    
    func setUI(){

        self.errorDescriptionLabel.text = self.apiError ?? ""
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
