//
//  APIManager.swift
//  Docubay
//
//  Created by Dhairya Vora on 21/08/2023.

import UIKit
import Foundation
import Alamofire

class DvNetworkManager: NSObject {
    
    //1 Managers and variables to be used in the calls
    private var defaultManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .useProtocolCachePolicy
        configuration.urlCache = URLCache.shared
        configuration.urlCache = URLCache(memoryCapacity: 4 * 1024 * 1024, diskCapacity: 20 * 1024 * 1024, diskPath: "URLCACHE")
        let afManager = Alamofire.SessionManager(configuration: configuration)
        return afManager
    }()
    
    let networkReachabilityManager = NetworkReachabilityManager(host: "www.apple.com")
    
    class func shared() -> DvNetworkManager {
        struct Static {
            //Singleton instance. Initializing Data manager.
            static let sharedInstance = DvNetworkManager()
        }
        /** @return Returns the default singleton instance. */
        return Static.sharedInstance
    }
    
    
    func getHeaders(method: APIMETHOD, cachePolicy: Bool = true) -> HTTPHeaders {
        switch method {
        case .POST:
            return [ "Content-Type": "application/json",
                    "Accept": "*/*",
                    "Authorization" : "\(defaults.string(forKey: token) ?? "")",
                    "Content-Length": "<calculated when request is sent>"]
            
        case .GET:
            if cachePolicy{
                return ["Content-Type": "application/json","Accept": "*/*", "Authorization" : "\(defaults.string(forKey: token) ?? "")"]
            } else{
                return ["Content-Type": "application/json","cache-control":"no-cache","Accept": "*/*",  "Authorization": "\(defaults.string(forKey: token) ?? "")"]
            }
            
        case .DELETE:
            if cachePolicy{
                return ["Content-Type": "application/json","Accept": "*/*", "Authorization" : "\(defaults.string(forKey: token) ?? "")"]
            } else{
                return ["Content-Type": "application/json","cache-control":"no-cache","Accept": "*/*",  "Authorization": "\(defaults.string(forKey: token) ?? "")"]
            }
        }
        
        
    }
    
    
    func postRequest(params: Parameters?, apiPath: String, closure: @escaping (ApiResults<Data, ServerError>) -> Void) {
        if !(networkReachabilityManager?.isReachable)! {
            closure(ApiResults.failure(ServerError.noInternetConnection(message: "Oops...looks like your internet connection is taking a break.", statusCode: 000)))
            return
        }else{
            let requestHeaders = getHeaders(method: .POST)
            print(requestHeaders)
            self.defaultManager.request(apiPath, method: .post, parameters: params, encoding: JSONEncoding.default, headers: requestHeaders).responseJSON { (response) in
                print(requestHeaders)
                print("Request status code====>>>>")
                print(response.response?.statusCode as Any)
                print("Parameters===",(params) as Any)
                switch response.result {
                case .success:
                    //let resJson = JSON(response.result.value!)
                    if response.response?.statusCode == 401{
                       
                    }else{
                        print("😊😊😊😊Data received Successfully of POST Request😊😊😊😊")
                        print("APIUrl===",(apiPath))
                        print("Parameters===",(params) as Any)
                        //print(resJson)
                        closure(ApiResults.success(response.data!))
                    }
                case .failure(let error):
                    print("Server😭😭😭😭Error Occurred😭😭😭😭")
                    print(error.localizedDescription)
                    print("================\(apiPath)=====================")
                    print(response.response?.statusCode ?? 0)
                    print(response.data ?? "")
                    //                print("😭😭😭😭\")
                    if error._code == NSURLErrorTimedOut {
                        closure(ApiResults.failure(ServerError.requestTimeOut(message: "Request Time Out")))
                    }else {
                        closure(ApiResults.failure(ServerError.unknownError(message: error.localizedDescription, statusCode: 000)))
                    }
                }
            }
        }
    }
    
    func getRequest(params: Parameters?, apiPath: String, cachePolicy: Bool = true,closure: @escaping (ApiResults<Data, ServerError>) -> Void) {
        if !(networkReachabilityManager?.isReachable)! {
            closure(ApiResults.failure(ServerError.noInternetConnection(message: "Oops...looks like your internet connection is taking a break.", statusCode: 000)))
            return
        }
        let requestHeaders = getHeaders(method: .GET,cachePolicy: cachePolicy)
        print(requestHeaders)
        self.defaultManager.request(apiPath, method: .get, parameters: params, encoding: JSONEncoding.default, headers: requestHeaders).responseData { (response) in
            //print(response.response?.statusCode)
            switch response.result {
            case .success:
                //let responseJson = JSON(response.result.value!)
                print("😊😊😊😊Data received Successfully of GET Request😊😊😊😊")
                print("==============\(apiPath)=================")
                print(response.response?.statusCode)
                if let statusCode = response.response?.statusCode, statusCode == 404 {
                    if response.data == nil {
                        closure(ApiResults.failure(ServerError.unknownError(message: "Request Time Out", statusCode: 404)))
                    }else{
                        closure(ApiResults.success(response.data!))
                    }
                } else {
                    closure(ApiResults.success(response.data!))
                }
            case .failure(let error):
                print("😭😭😭😭Error Occurred😭😭😭😭")
                print("==============\(apiPath)=================")
                if error._code == NSURLErrorTimedOut {
                    closure(ApiResults.failure(ServerError.requestTimeOut(message: "Request Time Out")))
                }else {
                    closure(ApiResults.failure(ServerError.unknownError(message: error.localizedDescription, statusCode: 000)))
                }
            }
        }
    }

    
    func delerteRequest(params: Parameters?, apiPath: String, closure: @escaping (ApiResults<Data, ServerError>) -> Void) {
        if !(networkReachabilityManager?.isReachable)! {
            closure(ApiResults.failure(ServerError.noInternetConnection(message: "Oops...looks like your internet connection is taking a break.", statusCode: 000)))
            return
        }else{
            let requestHeaders = getHeaders(method: .DELETE)
            print(requestHeaders)
            self.defaultManager.request(apiPath, method: .delete, parameters: params, encoding: JSONEncoding.default, headers: requestHeaders).responseJSON { (response) in
                print(requestHeaders)
                print("Request status code====>>>>")
                print(response.response?.statusCode as Any)
                print("Parameters===",(params) as Any)
                switch response.result {
                case .success:
                    //let resJson = JSON(response.result.value!)
                    if response.response?.statusCode == 401{
                       
                    }else{
                        print("😊😊😊😊Data received Successfully of POST Request😊😊😊😊")
                        print("APIUrl===",(apiPath))
                        print("Parameters===",(params) as Any)
                        //print(resJson)
                        closure(ApiResults.success(response.data!))
                    }
                case .failure(let error):
                    print("Server😭😭😭😭Error Occurred😭😭😭😭")
                    print(error.localizedDescription)
                    print("================\(apiPath)=====================")
                    print(response.response?.statusCode ?? 0)
                    print(response.data ?? "")
                    //                print("😭😭😭😭\")
                    if error._code == NSURLErrorTimedOut {
                        closure(ApiResults.failure(ServerError.requestTimeOut(message: "Request Time Out")))
                    }else {
                        closure(ApiResults.failure(ServerError.unknownError(message: error.localizedDescription, statusCode: 000)))
                    }
                }
            }
        }
    }
    
    
    
    
    
    
    
    

    func uploadImageToServer(image: UIImage, parameters: [String: Any], apiPath: String, completion: @escaping (ApiResults<Data, ServerError>) -> Void) {
        let imgData = image.jpegData(compressionQuality: 0.2)!
        let requestHeaders = getHeaders(method: .POST)
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imgData, withName: "image", fileName: "file.jpg", mimeType: "image/jpg")
            for (key, value) in parameters {
                if let data = (value as AnyObject).data(using: String.Encoding.utf8.rawValue) {
                    multipartFormData.append(data, withName: key)
                }
            }
            
            
        }, to: apiPath, method: .post, headers: requestHeaders) { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.responseData { response in
                    switch response.result {
                    case .success(let data):
                        completion(.success(data))
                    case .failure(let error):
                        completion(ApiResults.failure(ServerError.unknownError(message: error.localizedDescription, statusCode: 000)))
                    }
                }

            case .failure(let encodingError):
                completion(ApiResults.failure(ServerError.unknownError(message: encodingError.localizedDescription, statusCode: 000)))
            }
        }
    }
}


enum ApiResults<ValueType, ErrorType> {
    case success(ValueType)
    case failure(ErrorType)
}


enum ServerError {
    case noError
    case noInternetConnection(message: String, statusCode: Int)
    case unknownError(message: String, statusCode: Int)
    case requestTimeOut(message: String)
    case noDataAvailable(message: String)
    case wrongOtp(message: String)
    case forceLogoutUser(message: String)
    case SomethingWentWrong(message: String)
    case sessionInvalidated(message: String, statuscode: Int)
    
    func getErrorMessage() -> String {
        switch self {
        case .noInternetConnection(let message, _): return message
        case .unknownError(let message, _): return message
        case .requestTimeOut(let message): return message
        case .noDataAvailable(let message): return message
        case .noError:
            break
        case .wrongOtp(let message): return message
        case .forceLogoutUser(let message): return message
        case .SomethingWentWrong(let message): return message
        case .sessionInvalidated(let message,_): return message
        }
        return ""
    }
    
    func getStatuscode() -> Int{
        switch self {
        case .sessionInvalidated(_, let code):
            return code
        default:
            return 0
        }
    }
}

enum APIMETHOD: String {
    case POST
    case GET
    case DELETE
}

enum ResultSet<ValueType, ErrorType> {
    case success(ValueType)
    case failure(ErrorType)
}

extension Data {
   mutating func append(_ string: String) {
      if let data = string.data(using: .utf8) {
         append(data)
         print("data======>>>",data)
      }
   }
}
