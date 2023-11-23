//
//  PopUpViewController.swift
//  Bank 316
//
//  Created by Smt MacMini 3 on 04/11/23.
//

import UIKit

class PopUpViewController: UIViewController {
    
    @IBOutlet weak var lblmessage: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var image: UIImageView!
    var message:String?
    var imageHide:Bool? = false
    var changeAlertTypeIcon:Bool = false
    @IBOutlet weak var alertTypeIcon: UIImageView!
    var callBackAction:(()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblmessage.text = self.message
//        bgView.addBlurEffect(style:.regular, alpha: 0.4)
        bgView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        if self.changeAlertTypeIcon {
            self.alertTypeIcon.image = UIImage(named: "alertEmailVerify")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
            self.image.isHidden = imageHide ?? false
    }
    
    @IBAction func dismissButton(_ sender: UIButton) {
        self.dismiss(animated: true,completion: {
            guard let action = self.callBackAction else {return}
            action()
        })
    }
}


extension UIView {
    func addBlurEffect(style: UIBlurEffect.Style, alpha: CGFloat) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = UIScreen.main.bounds
        blurEffectView.alpha = alpha
        addSubview(blurEffectView)
    }
}
