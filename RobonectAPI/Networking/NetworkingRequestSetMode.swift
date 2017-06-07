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
//  NetworkingRequestSetMode.swift
//  Robonect
//
//  Created by Yannik Ehlert on 04.06.17.
//  Copyright © 2017 Yannik Ehlert. All rights reserved.
//

import Alamofire

public extension NetworkingRequest {
    public static func set(mode: RobonectAPI.ModeCode, remotestart: Int = 0, after: RobonectAPI.ModeCode = .unknown, start: String? = nil, end: String? = nil, mower: Mower, callback: @escaping ((_ result: Result<RobonectAPIResponse.Success>) -> Void)) {
        var parameters : [ String : Any ] = [ "cmd" : "mode" ]
        parameters["mode"] = mode.stringValue
        parameters["remotestart"] = remotestart
        if after != .unknown {
            parameters["after"] = after.afterValue
        }
        parameters["start"] = start
        parameters["end"] = end
        
        // Send a web request to the module
        Alamofire.request(mower.url, parameters: parameters).responseJSON { response in
            // Convert the response to a dictionary type, otherwise return the callback without result
            guard let value = response.value as? [ String : Any ] else {
                callback(Result<RobonectAPIResponse.Success>(response.request, response: response.response, error: response.error, value: nil))
                return
            }
            
            // Instantiate the Success result with the data the module sent
            let status = RobonectAPIResponse.Success(serverResponse: value)
            
            callback(Result<RobonectAPIResponse.Success>(response.request, response: response.response, error: response.error, value: status))
        }
    }
}
