//
//  RobonectAPIResponseSuccess.swift
//  Robonect
//
//  Created by Yannik Ehlert on 06.06.17.
//  Copyright © 2017 Yannik Ehlert. All rights reserved.
//

import Foundation

public extension RobonectAPIResponse {
    public struct Success {
        private let serverResponse : [ String : Any ]
        public init(serverResponse : [ String : Any ]) {
            self.serverResponse = serverResponse
        }
        
        /**
         Modules response wether it handled the request successfully.
         - returns: Response as bool
         */
        public var successful: Bool {
            return serverResponse["successful"] as? Bool ?? false
        }
    }
}
