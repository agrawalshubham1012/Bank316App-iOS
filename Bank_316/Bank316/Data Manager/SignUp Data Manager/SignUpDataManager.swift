//
//  SignUpDataManager.swift
//  Bank 316
//
//  Created by Dhairya on 13/09/23.
//

import Foundation

class SignUpDataManager {
    
    static let shared = SignUpDataManager()
    
    func signUpManager(params: [String:Any], completion: @escaping(ResultSet<ForgotPasswordModel ,ServerError>) -> Void){
        
        DvNetworkManager.shared().postRequest(params: params, apiPath: signUpUrl) { (result) in
            if Rechability.isConnectedToNetwork(){
                switch result{
                case .success(let data):
                    do{
                        let rootModel = try JSONDecoder().decode(ForgotPasswordModel.self, from: data)
                        if rootModel.status == true{
                            completion(.success(rootModel))
                        }else{
                            completion(.success(rootModel))
                        }
                    }
                    catch{
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    completion(.failure(error))
                    break
                }
            }else{
                return
            }
        }
    }
    
    
    //MARK Verify OTP Manager
    
    func verifyOtpManager(params: [String:Any], completion: @escaping(ResultSet<SignUpOtpModel ,ServerError>) -> Void){
        
        DvNetworkManager.shared().postRequest(params: params, apiPath: signupVerifyOtpUrl) { (result) in
            if Rechability.isConnectedToNetwork(){
                switch result{
                case .success(let data):
                    do{
                        let rootModel = try JSONDecoder().decode(SignUpOtpModel.self, from: data)
                        if rootModel.status == true{
                            completion(.success(rootModel))
                            UserDataManager.shared.createAccount(versionValue: rootModel)
                            defaults.set(rootModel.client?.token, forKey: token)
                        }else{
                            completion(.success(rootModel))
                        }
                    }
                    catch{
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    completion(.failure(error))
                    break
                }
            }else{
                return
            }
        }
    }
    
    //Post Code API
    
    func getPostCode(url: String, params: [String:Any], completion: @escaping(ResultSet<PostCodeModel ,ServerError>) -> Void){
        
        DvNetworkManager.shared().postRequest(params: params, apiPath: url) { (result) in
            if Rechability.isConnectedToNetwork(){
                switch result{
                case .success(let data):
                    do{
                        let rootModel = try JSONDecoder().decode(PostCodeModel.self, from: data)
                        if rootModel.status == "OK"{
                            completion(.success(rootModel))
                        }else{
                            completion(.success(rootModel))
                        }
                    }
                    catch{
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    completion(.failure(error))
                    break
                }
            }else{
                return
            }
        }
    }
}
