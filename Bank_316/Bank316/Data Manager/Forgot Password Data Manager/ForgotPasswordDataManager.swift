//
//  ForgotPasswordDataManager.swift
//  Bank 316
//
//  Created by Dhairya on 05/09/23.
//

import Foundation


class ForgotPasswordDataManager {
    
    static let shared = ForgotPasswordDataManager()
    func forgotPasswordManager(params: [String:Any], completion: @escaping(ResultSet<ForgotPasswordModel ,ServerError>) -> Void){
        
        DvNetworkManager.shared().postRequest(params: params, apiPath: forgotPasswordUrl) { (result) in
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
    
    func verifyOtpManager(params: [String:Any], completion: @escaping(ResultSet<ForgotPasswordModel ,ServerError>) -> Void){
        
        DvNetworkManager.shared().postRequest(params: params, apiPath: verifyOtpUrl) { (result) in
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
    
    //MARK Reset Password Manager
    
    func resetPasswordManager(params: [String:Any], completion: @escaping(ResultSet<ForgotPasswordModel ,ServerError>) -> Void){
        
        DvNetworkManager.shared().postRequest(params: params, apiPath: resetPasswordUrl) { (result) in
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
}
