//
//  ErrorResponse.swift
//  WIHP Project
//
//  Created by Nour Araar on 6/19/20.
//  Copyright © 2020 Nour Araar. All rights reserved.
//

import Foundation

class ErrorResponse: Codable {
    
    var message: String
    var code: Int
    
    init(message: String, code: Int) {
        self.message = message
        self.code = code
    }
}
