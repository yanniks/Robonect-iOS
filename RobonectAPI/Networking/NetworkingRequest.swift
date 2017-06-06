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
