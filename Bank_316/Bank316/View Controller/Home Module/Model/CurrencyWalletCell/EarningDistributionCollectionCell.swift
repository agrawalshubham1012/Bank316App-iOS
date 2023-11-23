//
//  EarningDistributionCollectionCell.swift
//  Bank 316
//
//  Created by Smt MacMini 3 on 08/11/23.
//

import UIKit

class EarningDistributionCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var imageBackView: UIView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.layer.cornerRadius = 22// Adjust the value as needed
        self.contentView.layer.masksToBounds = true
    }
    
    func setCellData(data:EarningModel){
        print(data)
        if let image = data.image {
            self.imageIcon.image = UIImage(named: image)
        }
        self.imageBackView.backgroundColor = data.color
        self.textLabel.text = data.title
        self.currencyLabel.text = "£\(data.currency ?? "")"
        self.percentageLabel.text = data.percentage
    }

}
