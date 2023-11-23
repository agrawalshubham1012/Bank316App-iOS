//
//  CreatedAccountPopup.swift
//  Bank 316
//
//  Created by Dhairya on 21/09/23.
//

import UIKit

class CreatedAccountPopup: UIViewController {

    
    @IBOutlet weak var lblmessage: UILabel!

    @IBOutlet weak var bgView: UIView!
    
    
    
    var message:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblmessage.text = self.message
//        bgView.addBlurEffect(style:.light, alpha: 0.6)

    }

    @IBAction func dismissButton(_ sender: UIButton) {
        self.dismiss(animated: true,completion: nil)
    }
}

