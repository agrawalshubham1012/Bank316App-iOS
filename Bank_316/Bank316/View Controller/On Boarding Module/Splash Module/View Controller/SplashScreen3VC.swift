//
//  SplashScreen3VC.swift
//  Bank 316
//
//  Created by Dhairya on 23/08/23.
//

import UIKit

class SplashScreen3VC: UIViewController {

    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var privacyPolicyButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    //MARK: - Action Events
    @IBAction func signInButton(_ sender: UIButton) {
        let vc: loginPageVC = loginPageVC.instantiateViewController(identifier: .login)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func privacyPolicyButton(_ sender: UIButton) {
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        let vc: SplashScreen4VC = SplashScreen4VC.instantiateViewController(identifier: .splash)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
