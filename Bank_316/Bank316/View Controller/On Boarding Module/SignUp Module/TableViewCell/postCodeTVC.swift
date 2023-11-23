//
//  postCodeTVC.swift
//  Bank 316
//
//  Created by Dhairya on 28/08/23.
//

import UIKit

class postCodeTVC: UITableViewCell {

    @IBOutlet weak var addressTwoLabel: UILabel!
    @IBOutlet weak var addressOne: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    internal func updateUI(address: String, formattedAddress: String){
        addressOne.text = address
        addressTwoLabel.text = formattedAddress
    }
}
