//
//  WalletCategoryCollectionCell.swift
//  Bank 316
//
//  Created by Smt MacMini 3 on 10/11/23.
//

import UIKit

class WalletCategoryCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var CurrentyTypeLabel: UILabel!
    @IBOutlet weak var currencyIconLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var addIcon: UIImageView!
    @IBOutlet weak var addWalletIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUI(data:Wallet?,index:Int,selectedIndex:Int?){

            if index == selectedIndex {
                self.addWalletIcon.isHidden = true
                self.currencyIconLabel.isHidden = false
                self.CurrentyTypeLabel.text = data?.currency?.title
                self.bgView.backgroundColor = .lemonGreen
                self.currencyIconLabel.textColor = .lemonGreen
                self.currencyIconLabel.text = data?.currency?.symbol
            }else{
                self.CurrentyTypeLabel.text = data?.currency?.title
                self.bgView.backgroundColor = .white
                if data?.currency?.title == "Add wallet" {
                    self.addWalletIcon.isHidden = false
                    self.currencyIconLabel.isHidden = true
                }else{
                    self.addWalletIcon.isHidden = true
                    self.currencyIconLabel.isHidden = false
                    self.currencyIconLabel.textColor = .white
                    self.currencyIconLabel.text = data?.currency?.symbol
                }
            }
    }
    
}
