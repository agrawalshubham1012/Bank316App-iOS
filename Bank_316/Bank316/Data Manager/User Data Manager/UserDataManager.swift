//
//  UserDataManager.swift
//  Bank 316
//
//  Created by Dhairya on 13/09/23.
//

import Foundation

class UserDataManager: NSObject{
    static let  shared = UserDataManager()
    
    
    var userName:String?{
        set{
            defaults.set(newValue, forKey: name)
        }
        get{
            defaults.value(forKey: name) as? String ?? ""
        }
    }

    
    var SignUpAccount : SignUpOtpModel? {
        get {
            if let data = defaults.object(forKey: signUpData) as? Data {
                do {
                    let value = try PropertyListDecoder().decode(SignUpOtpModel.self, from: data)
                    return value
                }
                catch {
                    return nil
                }
            }
            return nil
        }
        set {
            defaults.set(try? PropertyListEncoder().encode(newValue), forKey: signUpData)
            defaults.synchronize()
        }
    }
    
    
    var LoginAccount : LoginModel? {
        get {
            if let data = defaults.object(forKey: loginData) as? Data {
                do {
                    let value = try PropertyListDecoder().decode(LoginModel.self, from: data)
                    return value
                }
                catch {
                    return nil
                }
            }
            return nil
        }
        set {
            defaults.set(try? PropertyListEncoder().encode(newValue), forKey: loginData)
            defaults.synchronize()
        }
    }
    
    func updateCreatedUser(versionValue: LoginModel?) {
        if let versionModel = versionValue {
            LoginAccount = versionModel
        } else {
            defaults.removeObject(forKey: loginData)
            defaults.synchronize()
        }
    }
    
    func createAccount(versionValue: SignUpOtpModel?) {
        if let versionModel = versionValue {
            print(versionModel)
            SignUpAccount = versionModel
        } else {
            defaults.removeObject(forKey: signUpData)
            defaults.synchronize()
        }
    }
    
    
    var email:String?{
        set{
            defaults.set(newValue, forKey: loginEmail)
        }
        get{
            defaults.value(forKey: loginEmail) as? String
        }
    }
    
    
    var password:String?{
        set{
            defaults.set(newValue, forKey: loginPassword)
        }
        get{
            defaults.value(forKey: loginPassword) as? String
        }
    }
    
    
    func removeLoginUserCredential(){
        defaults.removeObject(forKey: loginEmail)
        defaults.removeObject(forKey: loginPassword)
        defaults.synchronize()
    }
    
    func removeUserData() {
        defaults.removeObject(forKey: loginData)
        defaults.synchronize()
    }
    
    func removeCreatedUser() {
        defaults.removeObject(forKey: signUpData)
        defaults.synchronize()
    }
}
