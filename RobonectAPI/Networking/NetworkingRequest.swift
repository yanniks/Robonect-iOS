//
//  Copyright (C) 2017 Yannik Ehlert.
//
//  Permission is hereby granted, free of charge, to any person obtaining a
//  copy of this software and associated documentation files (the "Software"),
//  to deal in the Software without restriction, including without limitation
//  the rights to use, copy, modify, merge, publish, distribute, sublicense,
//  and/or sell copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
//  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
//  DEALINGS IN THE SOFTWARE.
//
//
//  NetworkingRequest.swift
//  Robonect
//
//  Created by Yannik Ehlert on 03.06.17.
//  Copyright © 2017 Yannik Ehlert. All rights reserved.
//

import Alamofire

public class NetworkingRequest {
    public static func sendStatusRequest(mower: Mower, callback: @escaping ((_ result: Result<RobonectAPIResponse.Status>) -> Void)) {
        let parameters = [ "cmd" : "status" ]
        // Send a web request to the module
        Alamofire.request(mower.url, parameters: parameters).responseJSON { response in
            // Convert the response to a dictionary type, otherwise return the callback without result
            guard let value = response.value as? [ String : Any ] else {
                callback(Result<RobonectAPIResponse.Status>(response.request, response: response.response, error: response.error, value: nil))
                return
            }
            
            // Instantiate the Status result with the data the module sent
            let status = RobonectAPIResponse.Status(serverResponse: value)
            // Update the mowers name based on Robonects response
            if let name = status.name {
                mower.name = name
            }
            callback(Result<RobonectAPIResponse.Status>(response.request, response: response.response, error: response.error, value: status))
        }
    }
    /**
     Update the mowers name in Robonect
     */
    public static func set(name: String, mower: Mower, callback: @escaping ((_ result: Result<RobonectAPIResponse.Name>) -> Void)) {
        var parameters = [ "cmd" : "name" ]
        parameters["name"] = name
        // Send a web request to the module
        Alamofire.request(mower.url, parameters: parameters).responseJSON { response in
            // Convert the response to a dictionary type, otherwise return the callback without result
            guard let value = response.value as? [ String : Any ] else {
                callback(Result<RobonectAPIResponse.Name>(response.request, response: response.response, error: response.error, value: nil))
                return
            }
            
            // Instantiate the Name result with the data the module sent
            let status = RobonectAPIResponse.Name(serverResponse: value)
            // Update the mowers name based on Robonects response
            if let name = status.name {
                mower.name = name
            }
            callback(Result<RobonectAPIResponse.Name>(response.request, response: response.response, error: response.error, value: status))
        }
    }
}
