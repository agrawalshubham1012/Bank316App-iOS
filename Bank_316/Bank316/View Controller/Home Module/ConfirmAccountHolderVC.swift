//
//  ConfirmAccountHolderVC.swift
//  Bank 316
//
//  Created by Smt MacMini 3 on 22/11/23.
//

import UIKit

class ConfirmAccountHolderVC: UIViewController {
    
    var accountHolder:Bool?
    var jointAccount:Bool?
    var someOneElseAccount:Bool?
    var currencyData:Wallet?
    
    @IBOutlet weak var accountHolderCheckMark: UIImageView!
    @IBOutlet weak var jointAccountCheckMark: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func confirmButton(_ sender: UIButton) {
        let vc: AddAmountVC = AddAmountVC.instantiateViewController(identifier: .transaction)
        vc.paymentType = .manualBank
        vc.currencyData = self.currencyData
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func accountHolder(_ sender: UIButton) {
        self.accountHolder = true
        self.jointAccount = false
        self.someOneElseAccount = false
        self.setCheckMark()
    }
    
    @IBAction func joinAccountBUtton(_ sender: UIButton) {
        self.accountHolder = false
        self.jointAccount = true
        self.someOneElseAccount = false
        self.setCheckMark()
    }
    
    @IBAction func someOneElseAccountButton(_ sender: UIButton) {
        self.accountHolder = false
        self.jointAccount = false
        self.someOneElseAccount = true
    }
    
    func setCheckMark(){
        if self.accountHolder ?? false {
            self.accountHolderCheckMark.image = UIImage(named: "checkedMark")
            self.jointAccountCheckMark.image = UIImage(named: "uncheckMark")
        }else{
            self.accountHolderCheckMark.image = UIImage(named: "uncheckMark")
            self.jointAccountCheckMark.image = UIImage(named: "checkedMark")
        }
    }
}
