//
//  CardTableViewCell.swift
//  Bank 316
//
//  Created by Smt MacMini 3 on 16/11/23.
//

import UIKit
import StripePaymentsUI

class CardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var cardBranchIcon: UIImageView!
    @IBOutlet weak var rightIcon: UIImageView!
    @IBOutlet weak var cardDeleteButton: UIButton!
    var deleteCardAction:((Int)->())?
    var cardData:Card?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setUI(data:Card?,deleteCard:Bool){
        let cardBrand = STPCardValidator.brand(forNumber: data?.cardNumber ?? "")
        let cardBrandImageName = self.cardBrandImageName(for: cardBrand)
        self.cardBranchIcon.image = cardBrandImageName
        self.cardData = data
        self.cardDeleteButton.isHidden = !deleteCard
        self.rightIcon.isHidden = deleteCard
        self.cardNumberLabel.text = formatCreditCardNumber(data?.cardNumber ?? "")
    }
    
    @IBAction func cardDeleteButton(_ sender: UIButton) {
        print(self.cardData as Any)
        guard let action = self.deleteCardAction else{return}
        action(self.cardData?.id ?? 0)
    }
    
    
    func formatCreditCardNumber(_ cardNumber: String) -> String {
        
        var formattedString = ""
        var index = cardNumber.startIndex
        
        // Iterate through the string and add spaces after every 4 characters
        while index < cardNumber.endIndex {
            let nextIndex = cardNumber.index(index, offsetBy: 4, limitedBy: cardNumber.endIndex) ?? cardNumber.endIndex
            let chunk = cardNumber[index..<nextIndex]
            
            formattedString += String(chunk)
            if nextIndex != cardNumber.endIndex {
                formattedString += " "
            }
            
            index = nextIndex
        }
        
        let cardNumbers =  formattedString
        
        let components = cardNumbers.components(separatedBy: " ")
        guard components.count == 4 else { return cardNumbers } // Check if it has 4 components
        
        var formattedStrings = ""
        for (index, component) in components.enumerated() {
            if index == 3 {
                formattedStrings += component.suffix(4)
            } else {
                formattedStrings += "XXXX"
            }
            formattedStrings += " "
        }
        
        return formattedStrings.trimmingCharacters(in: .whitespaces)
    }
    
    
    func cardBrandImageName(for brand: STPCardBrand) -> UIImage? {
        switch brand {
        case .amex:
            return STPImageLibrary.amexCardImage()
        case .visa:
            return STPImageLibrary.visaCardImage()
        case .mastercard:
            return STPImageLibrary.mastercardCardImage()
        case .discover:
            return STPImageLibrary.discoverCardImage()
        case .JCB:
            return STPImageLibrary.jcbCardImage()
        case .dinersClub:
            return STPImageLibrary.dinersClubCardImage()
        case .unionPay:
            return STPImageLibrary.unionPayCardImage()
        case .unknown:
            return STPImageLibrary.unknownCardCardImage()
        @unknown default:
            return UIImage()
        }
    }
    
    
    
    
//    func detectCreditCardType(cardNumber: String) -> String {
//        let cleanedNumber = cardNumber.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "-", with: "")
//        
//        switch cleanedNumber.prefix(2) {
//        case "34", "37":
//            return "American Express"
//        case "36":
//            return "Diners Club"
//        case "38":
//            return "Carte Blanche"
//        case "51"..."55":
//            return "masterCardLogo"
//        default:
//            switch cleanedNumber.prefix(4) {
//            case "2014", "2149":
//                return "EnRoute"
//            case "2131", "1800":
//                return "JCB"
//            case "6011":
//                return "Discover"
//            default:
//                switch cleanedNumber.prefix(3) {
//                case "300"..."305":
//                    return "American Diners Club"
//                default:
//                    switch cleanedNumber.prefix(1) {
//                    case "3":
//                        return "JCB"
//                    case "4":
//                        return "visaLogo"
//                    default:
//                        return "visaLogo"
//                    }
//                }
//            }
//        }
//    }
}



