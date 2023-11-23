//
//  LoginDataManager.swift
//  Bank 316
//
//  Created by Dhairya on 04/09/23.
//

import Foundation


class LoginDataManager {
    
    static let shared = LoginDataManager()
    func loginManager(params: [String:Any], completion: @escaping(ResultSet<LoginModel ,ServerError>) -> Void){
        
        DvNetworkManager.shared().postRequest(params: params, apiPath: loginUrl) { (result) in
            if Rechability.isConnectedToNetwork(){
                switch result{
                case .success(let data):
                    do{
                        let rootModel = try JSONDecoder().decode(LoginModel.self, from: data)
                        if rootModel.status == true{
                            UserDataManager.shared.updateCreatedUser(versionValue: rootModel)
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
