//
//  CustomError.swift
//  Bank 316
//
//  Created by Iplexuss Software Solutions on 20/10/23.
//

import Foundation

class CustomError {
    
    var title: String?
    var message: String
    var code: Int
    var domain: String
    
    init(title: String?, message: String, domain: String = "com.myproject.error", code: Int) {
        self.title = title
        self.domain = domain
        self.message = message
        self.code = code
    }
}
