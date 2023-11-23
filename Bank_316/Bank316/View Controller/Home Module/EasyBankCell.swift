//
//  EasyBankCell.swift
//  Bank 316
//
//  Created by Smt MacMini 3 on 20/11/23.
//

import UIKit

class EasyBankCell: UITableViewCell {
    
    @IBOutlet weak var bankIcon: UIImageView!
    @IBOutlet weak var bankNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCellUI(data:TestBank){
        if let iconUrl = data.iconURL {
            self.bankIcon.sd_setImageCustom(url:"\(iconUrl).jpg")
        }
        self.bankNameLabel.text = data.name
    }
}
