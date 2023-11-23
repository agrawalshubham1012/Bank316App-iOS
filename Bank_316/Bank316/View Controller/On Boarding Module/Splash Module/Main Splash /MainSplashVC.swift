//
//  MainSplashVC.swift
//  Bank 316
//
//  Created by Dhairya on 01/09/23.
//

import UIKit

class MainSplashVC: UIViewController {

    @IBOutlet weak var gifImageView: UIImageView!
    
    var timer: Timer?
    var secondsRemaining = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()
        let jeremyGif = UIImage.gifImageWithName("Splash")
        self.gifImageView.image = jeremyGif
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopTimer()
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
                    if defaults.string(forKey: token) == nil && defaults.bool(forKey: splash) == false{
                        let vc: SplashScreen1VC = SplashScreen1VC.instantiateViewController(identifier: .splash)
                        self.navigationController?.pushViewController(vc, animated: true)
                    }else if defaults.string(forKey: token) == nil && defaults.bool(forKey: splash) {
                        let vc: loginPageVC = loginPageVC.instantiateViewController(identifier: .login)
                        self.navigationController?.pushViewController(vc, animated: true)
                    }else if defaults.string(forKey: token) != nil && defaults.bool(forKey: tabbar){
                        let vc: DvTabBarController = DvTabBarController.instantiateViewController(identifier: .home)
                        self.navigationController?.pushViewController(vc, animated: true)
                    }else if defaults.string(forKey: token) != nil && defaults.bool(forKey: splash) && defaults.bool(forKey: tabbar) == false {
                        let vc: loginPageVC = loginPageVC.instantiateViewController(identifier: .login)
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    Timer.invalidate()
                }
            }
        }
    }
    
   private func stopTimer(){
       self.gifImageView.image = nil
       self.timer?.invalidate()
       self.timer = nil
    }
}
