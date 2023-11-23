//
//  SplashScreen2VC.swift
//  Bank 316
//
//  Created by Dhairya on 23/08/23.
//

import UIKit

class SplashScreen2VC: UIViewController {

    @IBOutlet weak var privacyPolicyButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    //MARK: - Action Events
    @IBAction func privacyPolicyButton(_ sender: UIButton) {
    }
    
    @IBAction func signInButton(_ sender: UIButton) {
        let vc: loginPageVC = loginPageVC.instantiateViewController(identifier: .login)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func nextButton(_ sender: UIButton) {
        let vc: SplashScreen3VC = SplashScreen3VC.instantiateViewController(identifier: .splash)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
