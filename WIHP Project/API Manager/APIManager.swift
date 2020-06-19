//
//  APIManager.swift
//  WIHP Project
//
//  Created by Nour Araar on 6/19/20.
//Copyright © 2020 Nour Araar. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    
    init() {
        Alamofire.SessionManager.default.session.configuration.timeoutIntervalForRequest = 3
    }
    
    // Generic api request with mapping to the object
    static func request<T: Codable, E: Codable>(url: String, method: HTTPMethod, headers: [String: String] = [:], parameters: [String: Any] = [:] , isAuth: Bool, successHandler success: @escaping (_ response: T) -> Void, failureHandler fail: @escaping(_ statusCode: Int,_ response: E) -> Void, decodingFailerHandler decodingFail: @escaping(_ response: DataResponse<Data>,_ message: String ,_ code: Int) -> Void = {_,_,_   in }) {
        var params: [String: Any]? = parameters
        var requestedUrl = url
        
        if method == .get {
            requestedUrl += dicToURLRequestParameter(parameters: params!)
            params = nil
        }
        Alamofire.request(requestedUrl, method: method, parameters: params, encoding: method == .get ? URLEncoding.default : JSONEncoding.default, headers: headers).responseData { response in
            #if DEBUG
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                  print("Data From BankEnd for \(requestedUrl): >>>>>>>>>>>>>>  \(utf8Text) ")
              }
            #endif
            switch response.result {
            case .success:
                if response.response?.statusCode == 200 || response.response?.statusCode == 201 {
                    if let obj: T = parseObject(response) {
                            success(obj)
                        
                    } else {
                        decodingFail(response, "\(url): On success : decoding json error", 2)
                    }
                } else {
                    if let obj: E = parseObject(response) {
                        fail(response.response?.statusCode ?? 1, obj)
                    } else {
                        decodingFail(response, "\(url): On Failer : decoding json error" , 3)
                    }
                }
            case .failure:
                if let obj: E = parseObject(response) {
                    fail(response.response?.statusCode ?? 1, obj)
                } else {
                    decodingFail(response, "No Internet Connection" , ErrorStatusCode.connectionError.rawValue)
                }
            }
        }
    }
    
    private static func parseObject<T: Codable>(_ response: DataResponse<Data>) -> T? {
        do {
            let jsonDecoder = JSONDecoder()
            if let data = response.result.value {
                let obj = try jsonDecoder.decode(T.self, from: data)
                return obj
            }
            return nil
        } catch {
            if let decodingError = error as? DecodingError {
                print("\(T.self) faild to parser \(decodingError)")
            }
            
            return nil
        }
    }
    
    // Generate request parameters from dic
    private static func dicToURLRequestParameter(parameters: [String: Any]) -> String {
        var resultString = "?"
        for (k,v) in parameters {
            resultString += "\(k)=\(String(describing: v))&"
        }
        return parameters.count > 0 ? resultString : ""
    }
}
