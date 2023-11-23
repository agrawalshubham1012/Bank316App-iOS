//
//  SplashScreen4VC.swift
//  Bank 316
//
//  Created by Dhairya on 23/08/23.
//

import UIKit

class SplashScreen4VC: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var privacyPolicyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    //MARK: - Action Events
    @IBAction func nextButton(_ sender: UIButton) {
        let vc: loginPageVC = loginPageVC.instantiateViewController(identifier: .login)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func privacyPolicyButton(_ sender: UIButton) {
        
    }
    
    @IBAction func signInButton(_ sender: UIButton) {
        let vc: loginPageVC = loginPageVC.instantiateViewController(identifier: .login)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
