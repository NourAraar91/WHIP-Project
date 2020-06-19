//
//  AppAPIManager.swift
//  WIHP Project
//
//  Created by Nour Araar on 6/19/20.
//Copyright © 2020 Nour Araar. All rights reserved.
//

import Foundation
import Alamofire

enum ErrorStatusCode: Int {
    case forbidden = 403
    case internalServerError = 500
    case unAuthorized = 401
    case unprocessableEntity = 422
    case badRequest = 400
    case ok = 200
    case invalidURL = 999
    case connectionError = 1009
}

class AppAPIManager {
    
    static let shared: AppAPIManager = AppAPIManager()
    
    // Generic calling service
    func callAPI<T:Codable>(url: String, parameters: [String : Any] = [:], method: HTTPMethod, headers:[String : String] = [:], isAuth: Bool, shouldClearCache: Bool = false, successHandler success: @escaping (_ response: T) -> Void, failureHandler fail: @escaping(_ response: ErrorResponse) -> Void = { _ in }) {
        
        if shouldClearCache {
            // here to clear the hub spot cache
            URLCache.shared.removeAllCachedResponses()
            HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        }
        
        APIManager.request(url: url, method: method, headers: headers, parameters: parameters,isAuth: isAuth, successHandler: success, failureHandler: { (status: Int, obj: GenericResponse) in
            guard let statusCode = ErrorStatusCode(rawValue: status) else {
                fail(ErrorResponse(message: "Connection Error", code: ErrorStatusCode.connectionError.rawValue))
                return
            }
            switch statusCode {
            case .unprocessableEntity, .badRequest , .unAuthorized:
                fail(ErrorResponse(message: "Connection Error", code: ErrorStatusCode.connectionError.rawValue))
            default:
                fail(ErrorResponse(message: "Connection Error", code: ErrorStatusCode.connectionError.rawValue))
            }
        }) {(response, error , code) in
            fail(ErrorResponse(message: error, code: code))
        }
    }
}
