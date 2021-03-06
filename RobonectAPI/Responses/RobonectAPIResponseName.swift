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
//  RobonectAPIResponseName.swift
//  Robonect
//
//  Created by Yannik Ehlert on 04.06.17.
//

import Foundation

public extension RobonectAPIResponse {
    public struct Name {
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
        
        /**
         The mowers name as specified in Robonect.
         - returns: Currently set name in Robonect as String.
         */
        public var name: String? {
            return serverResponse["name"] as? String
        }
    }
}
