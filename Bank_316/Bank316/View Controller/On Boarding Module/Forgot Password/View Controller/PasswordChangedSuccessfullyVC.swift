//
//  PasswordChangedSuccessfullyVC.swift
//  Bank 316
//
//  Created by Dhairya on 30/08/23.
//

import UIKit

class PasswordChangedSuccessfullyVC: UIViewController {

    @IBOutlet weak var gifImage: UIImageView!
    
    var timer: Timer?
    var secondsRemaining = 11
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startTimer()
        let jeremyGif = UIImage.gifImageWithName("Password_Changed_Successfully")
        self.gifImage.image = jeremyGif
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.stopTimer()
    }

    //MARK: - Timer For Gif
    private func startTimer(){
        if timer == nil {
            timer =  Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
                if self.secondsRemaining > 0 {
                    print ("\(self.secondsRemaining) seconds")
                    self.secondsRemaining -= 1
                } else {
                    print("Invalidateeee")
                    let vc: loginPageVC = loginPageVC.instantiateViewController(identifier: .login)
                    self.navigationController?.pushViewController(vc, animated: true)
                    Timer.invalidate()
                }
            }
        }
    }
    
   private func stopTimer(){
       self.gifImage.image = nil
       self.timer?.invalidate()
       self.timer = nil
    }
    
    //MARK: - Action Events
    
    @IBAction func privacyPolicyButton(_ sender: UIButton) {
        
    }
    
    @IBAction func backToLoginButton(_ sender: UIButton) {
        let vc: loginPageVC = loginPageVC.instantiateViewController(identifier: .login)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
