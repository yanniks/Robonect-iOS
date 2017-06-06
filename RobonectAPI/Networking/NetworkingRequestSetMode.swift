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
