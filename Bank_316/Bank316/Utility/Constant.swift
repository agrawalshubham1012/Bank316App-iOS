//
//  Constant.swift
//  Bank 316
//
//  Created by Dhairya on 21/08/23.
//

import Foundation

 let defaults = UserDefaults.standard

let url : String = "https://tgu90.com:3006/"
let postCodeKey: String = "AIzaSyAXKFSYA9di9ojX0orUk_BfwMFnYtHt1fw"

let BASE_URL = url

//MARK: - Onboarding API

let loginUrl = BASE_URL + "client/login"
let forgotPasswordUrl = BASE_URL + "client/forget-password"
let verifyOtpUrl = BASE_URL + "client/forget-password-verify-otp"
let resetPasswordUrl = BASE_URL + "client/reset-password"
let countriesListUrl = BASE_URL + "client/countries"
let signUpUrl = BASE_URL + "client/signup"
let signupVerifyOtpUrl = BASE_URL + "client/verify-otp"
let newPasswordUrl = BASE_URL + "change-password"
let completeProfileUrl = BASE_URL + "client/complete-profile"
let homePageUrl = BASE_URL + "client/home-page"
let resendEmail = BASE_URL + "client/resend-email"
let idVerificationUrl = BASE_URL + "client/upload-govt-identity"
let userPhotoVerificationUrl = BASE_URL + "client/upload-face-photo"
let docVerificationUrl = BASE_URL + "client/doc-verify"
let getTransactionUrl = BASE_URL + "client/currency-wallet-transaction/"
let getTransactionFee = BASE_URL + "client/currency-wallet/add-money/detail/"
let getCardList = BASE_URL + "client/card/get/list"
let deleteCard = BASE_URL + "client/card/delete/"
let addMoney = BASE_URL + "client/currency-wallet/add-money/"
let addCard = BASE_URL + "client/card/create"
let getBankLists = BASE_URL + "client/get-moneyhub-bank"
let getMoneyHubPaymentUrl = BASE_URL + "client/currency-wallet/add-money/money-hub/"
let moneyHubCallBackUrl = BASE_URL + "client/moneyhub/getcallback"
let manualBankListUrl = BASE_URL + "client/get-currency-bank/"
let addMoneyManualBank = BASE_URL + "client/currency-wallet/add-money/manual-bank/"


//MARK: - Constant UserDefault Keys

let token = "Token"
let splash = "splash"
let signUpData = "SignUp"
let loginData = "Login"
let name = "userName"
let loginEmail = "loginEmail"
let loginPassword = "loginPassword"
let tabbar = "Tabbar"
