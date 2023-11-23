//
//  SplashScreen1VC.swift
//  Bank 316
//
//  Created by Dhairya on 23/08/23.
//

import UIKit

class SplashScreen1VC: UIViewController {

    @IBOutlet weak var privacyPolicyButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    //MARK: - Action Events
    @IBAction func privacyPolicyButton(_ sender: UIButton) {
        
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        let vc: SplashScreen2VC = SplashScreen2VC.instantiateViewController(identifier: .splash)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func signInButton(_ sender: UIButton) {
        let vc: loginPageVC = loginPageVC.instantiateViewController(identifier: .login)
      // let vc: DvTabBarController = DvTabBarController.instantiateViewController(identifier: .home)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
