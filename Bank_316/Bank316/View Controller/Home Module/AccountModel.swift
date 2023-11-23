//
//  AccountModel.swift
//  Bank 316
//
//  Created by Smt MacMini 3 on 02/11/23.
//

import Foundation

struct AccountModel{
    var title:String?
    var description:String?
    
    init(title:String,description:String){
        self.title = title
        self.description = description
    }
}


enum AccountTitle:String {
    case profile = "Profile"
    case savedAddress = "Saved Address"
    case savedBanks = "Saved Banks"
    case securityAndPrivacy = "Security and Privacy"
    case statementsAndReports = "Statements and Reports"
    case manageNotifications = "Manage Notifications"
    case helpAndSupport = "Help and Support"
    case preferences = "Preferences"
    case purchaseAndPoints = "Purchase and Points"
    case legal = "Legal"
    case myReferrals = "My Referrals"
    case closeAccount = "Close Account"
}

enum AccountList: String,CaseIterable{
    case profile = "Profile:Login Details"
    case savedAddress = "Saved Address:Address"
    case savedBanks = "Saved Banks:Saved Banks, Saved Cards"
    case securityAndPrivacy = "Security and Privacy:Change your password"
    case statementsAndReports = "Statements and Reports:Standard Statement, Trading Statement"
    case manageNotifications = "Manage Notifications:Notifications"
    case helpAndSupport = "Help and Support:Message Center, Book A Call"
    case preferences = "Preferences:Modify your preferences"
    case purchaseAndPoints = "Purchase and Points:Purchase and Points"
    case legal = "Legal:Terms of Use, Customer Agreement"
    case myReferrals = "My Referrals:Referrals"
    case closeAccount = "Close Account:Close 316 Account, Close Training Account"
}



