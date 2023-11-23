//
//  InstructionVC.swift
//  Bank 316
//
//  Created by Dhairya on 25/09/23.
//

import UIKit

class InstructionVC: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func continueButton(_ sender: UIButton) {
        let vc: SelfieVC =  SelfieVC.instantiateViewController(identifier: .verification)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
