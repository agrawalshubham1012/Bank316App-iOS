//
//  CountryListTVC.swift
//  Bank 316
//
//  Created by Dhairya on 25/08/23.
//

import UIKit



class CountryListTVC: UITableViewCell {

    @IBOutlet weak var countryFlagImage: UIImageView!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var countrySelectionImage: UIImageView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
 
    //MARK: - Internal function for update UI
    internal func updateUI(data: CountriesNameModel?){
        self.countryFlagImage.sd_setImageCustom(url: data?.country_flag ?? "")
        self.countryNameLabel.text = data?.country_name ?? ""
    }
}
