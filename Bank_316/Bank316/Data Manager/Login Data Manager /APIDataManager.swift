//
//  HomeDataManager.swift
//  Bank 316
//
//  Created by Smt MacMini 3 on 04/11/23.
//

import Foundation
import UIKit

class APIDataManager {
    
    static let shared = APIDataManager()
    
    func fetchHomeData(completion: @escaping(ResultSet<HomePageResponseModel ,ServerError>) -> Void){
        DvNetworkManager.shared().getRequest(params: nil, apiPath:homePageUrl) { (result) in
            if Rechability.isConnectedToNetwork(){
                switch result{
                case .success(let data):
                    do{
                        let rootModel = try JSONDecoder().decode(HomePageResponseModel.self, from: data)
                        if rootModel.status == true{
                            completion(.success(rootModel))
                        }else{
                            completion(.success(rootModel))
                        }
                    }
                    catch let error {
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
    
    
    func resendMailVerify(completion: @escaping(ResultSet<EmailVerificationResponseModel,ServerError>) -> Void){
        DvNetworkManager.shared().getRequest(params: nil, apiPath:resendEmail) { (result) in
            if Rechability.isConnectedToNetwork(){
                switch result{
                case .success(let data):
                    do{
                        let rootModel = try JSONDecoder().decode(EmailVerificationResponseModel.self, from: data)
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
    
    func uploadGovtId(image:UIImage,params: [String:Any], completion: @escaping(ResultSet<IdVerificationResponseModel ,ServerError>) -> Void){
        
        DvNetworkManager.shared().uploadImageToServer(image: image, parameters: params, apiPath:idVerificationUrl){ (result) in
            if Rechability.isConnectedToNetwork(){
                switch result{
                case .success(let data):
                    do{
                        let json = try JSONSerialization.jsonObject(with: data) as! [String:Any]
                        print(json)
                        let rootModel = try JSONDecoder().decode(IdVerificationResponseModel.self, from: data)
                        completion(.success(rootModel))
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
    
    
    func uploadUserPhoto(image:UIImage,params: [String:Any], completion: @escaping(ResultSet<SelfieResponseModel ,ServerError>) -> Void){
        
        DvNetworkManager.shared().uploadImageToServer(image: image, parameters: params, apiPath:userPhotoVerificationUrl){ (result) in
            if Rechability.isConnectedToNetwork(){
                switch result{
                case .success(let data):
                    do{
                        let json = try JSONSerialization.jsonObject(with: data) as! [String:Any]
                        print(json)
                        let rootModel = try JSONDecoder().decode(SelfieResponseModel.self, from: data)
                        completion(.success(rootModel))
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
    
    func finalDocVerification(completion: @escaping(ResultSet<FinalVerificationResponseModel ,ServerError>) -> Void){
        DvNetworkManager.shared().getRequest(params: nil, apiPath:docVerificationUrl) { (result) in
            if Rechability.isConnectedToNetwork(){
                switch result{
                case .success(let data):
                    do{
                        let rootModel = try JSONDecoder().decode(FinalVerificationResponseModel.self, from: data)
                        completion(.success(rootModel))
                    }
                    catch let error {
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
    
    func getData<T:Codable>(url:String,param:[String:Any],completion: @escaping(ResultSet<T,ServerError>) -> Void){
        DvNetworkManager.shared().getRequest(params: nil, apiPath:url) { (result) in
            if Rechability.isConnectedToNetwork(){
                switch result{
                case .success(let data):
                    do{
                        let rootModel = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(rootModel))
                    }
                    catch let error {
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
    
    
    func postData<T:Codable>(url:String,param:[String:Any],completion: @escaping(ResultSet<T,ServerError>) -> Void){
        DvNetworkManager.shared().postRequest(params: param, apiPath:url ) { result in
            if Rechability.isConnectedToNetwork(){
                switch result{
                case .success(let data):
                    do{
                        print(try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any])
                        let rootModel = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(rootModel))
                    }
                    catch let error {
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
    
    func deleteData<T:Codable>(url:String,param:[String:Any],completion: @escaping(ResultSet<T,ServerError>) -> Void){
        DvNetworkManager.shared().delerteRequest(params: param, apiPath:url ) { result in
            if Rechability.isConnectedToNetwork(){
                switch result{
                case .success(let data):
                    do{
                        let rootModel = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(rootModel))
                    }
                    catch let error {
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
