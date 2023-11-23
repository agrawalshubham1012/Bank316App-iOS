//
//  CountryListDataManager.swift
//  Bank 316
//
//  Created by Dhairya on 07/09/23.
//

import Foundation

class CountryListDataManager {
    static let shared = CountryListDataManager()
    func countryListManager(completion: @escaping(ResultSet<CountryListModel ,ServerError>) -> Void){
        
        DvNetworkManager.shared().getRequest(params: nil, apiPath: countriesListUrl) { (result) in
            if Rechability.isConnectedToNetwork(){
                switch result{
                case .success(let data):
                    do{
                        let rootModel = try JSONDecoder().decode(CountryListModel.self, from: data)
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


