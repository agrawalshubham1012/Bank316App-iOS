//
//  CompleteVerificationVC.swift
//  Bank 316
//
//  Created by Smt MacMini 3 on 06/11/23.
//

import UIKit

class CompleteVerificationVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func docIDRetakeButton(_ sender: UIButton) {
        let vc: IdVerificationVC = IdVerificationVC.instantiateViewController(identifier: .verification)
        vc.isFromCompleteProfile = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func photoRetakeButton(_ sender: UIButton) {
        let vc: SelfieVC = SelfieVC.instantiateViewController(identifier: .verification)
        vc.isFromCompleteProfile = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func exploreButton(_ sender: UIButton) {
        let vc: DvTabBarController = DvTabBarController.instantiateViewController(identifier: .home)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
