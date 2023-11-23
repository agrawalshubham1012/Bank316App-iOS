//
//  EmailVerificationVC.swift
//  Bank 316
//
//  Created by Dhairya on 22/09/23.
//

import UIKit

class EmailVerificationVC: UIViewController {
    
    
    @IBOutlet var bgView: UIView!
    @IBOutlet weak var resendButton: UIButton!
    @IBOutlet weak var findHelpButton: UIButton!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    var emailD:String?
    var message:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAttributedText()
    }
    
    //MARK: - Action Events
    @IBAction func resendButton(_ sender: UIButton) {
        resendEmailAPI()
    }
    
    @IBAction func findHelpButton(_ sender: UIButton) {
        //        let vc: BriefVC = BriefVC.instantiateViewController(identifier: .verification)
        //        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}


extension EmailVerificationVC{
    
    private func resendEmailAPI(){
        startAnimation(view: self.view)
        self.bgView.backgroundColor = .appGreen
        APIDataManager.shared.resendMailVerify() { result in
            switch result{
            case .success(let data):
                defer{
                    stopAnimation(view: self.view)
                }
                self.message = data.message ?? ""
                self.showPopUp()
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func showPopUp(){
        let popupVC: PopUpViewController = PopUpViewController.instantiateViewController(identifier: .home)
        popupVC.message = self.message ?? ""
        popupVC.imageHide = true
        popupVC.changeAlertTypeIcon = true
        popupVC.modalPresentationStyle = .overCurrentContext
        popupVC.modalTransitionStyle = .crossDissolve
        self.navigationController?.present(popupVC, animated: true, completion: nil)
    }
    
    
    
    func setAttributedText() {
        let text = "When you signed up, we sent you a message about verifying your email. Click the magic link we've sent to : \(self.emailD ?? "")"
        descLabel.text = text
        descLabel.textColor = UIColor.white
        
        let underlineAttriString = NSMutableAttributedString(string: text)
        let range1 = (text as NSString).range(of: self.emailD ?? "")
        
        underlineAttriString.addAttribute(.font, value: UIFont.init(name: "HelveticaNeue", size: 14.0)!, range: range1)
        underlineAttriString.addAttribute(.foregroundColor, value: UIColor(red: 159/255, green: 232/255, blue: 112/255,alpha: 1), range: range1)
        descLabel.attributedText = underlineAttriString
        descLabel.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapLabel))
        descLabel.addGestureRecognizer(tapGesture)
    }
    
    
    @objc func tapLabel(gesture: UITapGestureRecognizer) {
        let text = "When you signed up, we sent you a message about verifying your email. Click the magic link we've sent to : \(self.emailD ?? "")"
        let range = (text as NSString).range(of: self.emailD ?? "")
        if gesture.didTapAttributedTextInLabel(label: descLabel, inRange: range) {
            print("email")
        }
    }
}


