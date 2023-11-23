//
//  WalletCellTableViewCell.swift
//  Bank 316
//
//  Created by Smt MacMini 3 on 08/11/23.
//

import UIKit

class WalletCellTableViewCell: UITableViewCell {

    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyIcon: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        self.contentView.layer.cornerRadius = 15 // Adjust the value as needed
//        self.contentView.layer.masksToBounds = true
        self.contentView.backgroundColor = .white
    }
    
    
    func setCellData(data:Wallet?){
        self.currencyIcon.sd_setImageCustom(url: data?.currency?.icon ?? "")
        self.currencyLabel.text = "\(data?.currency?.title ?? "") - \(data?.currency?.shortName ?? "")"
    }

}
