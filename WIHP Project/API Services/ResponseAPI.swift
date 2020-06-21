//
//  ResponseAPI.swift
//  WIHP Project
//
//  Created by Nour Araar on 6/19/20.
//Copyright © 2020 Nour Araar. All rights reserved.
//

import Foundation
import Alamofire

final class ResponseAPI: GenericService {

    func request(scope: String,completionHandler handler: @escaping (_ response: ResponseAPIResponse) -> Void, failureHandler failHandler: @escaping(_ error: ErrorResponse) -> Void = { _ in }) {
        let url = "https://skyrim.whipmobility.io/v10/analytic/dashboard/operation/mock?scope=\(scope)"
        let parameters: [String: Any] = [:]
        let headers = self.getHeaders()
        // here just set the type of method (.get, .post,.put....)
        // set the header if there is
        // authorised is true if you want to send the token in the request and false otherwise
        self.api.callAPI(url: url, parameters: parameters, method: .get, headers: headers ,isAuth: false , successHandler: { (response: ResponseAPIResponse) in
            print(response)
            handler(response)
        }) { (error) in
            failHandler(error)
        }
    }
}




