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
//  RobonectAPIResponseStatus.swift
//  Robonect
//
//  Created by Yannik Ehlert on 03.06.17.
//

import Foundation

public extension RobonectAPIResponse {
    public struct Status {
        private let serverResponse : [ String : Any ]
        public let status : Status
        public let timer : Timer
        public let wlan : WLAN
        public let error : Error
        public init(serverResponse : [ String : Any ]) {
            self.serverResponse = serverResponse
            status = Status(serverResponse["status"] as? [ String : Any ])
            timer = Timer(serverResponse["timer"] as? [ String : Any ])
            wlan = WLAN(serverResponse["wlan"] as? [ String : Any ])
            error = Error(serverResponse["error"] as? [ String : Any ])
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
        
        public struct Status {
            private let serverResponseStatus : [ String : Any ]
            init(_ serverResponseStatus : [ String : Any ]?) {
                self.serverResponseStatus = serverResponseStatus ?? [ String : Any ]()
            }
            /**
             The mowers current status.
             - returns: Status and status code as value of the enumeration.
             */
            public var status : RobonectAPI.StatusCode {
                return RobonectAPI.StatusCode(rawValue: serverResponseStatus["status"] as? Int ?? 0) ?? .unknown
            }
            /**
             The duration the mower is in the current state.
             - returns: Duration in seconds
             */
            public var duration : Int {
                return serverResponseStatus["duration"] as? Int ?? 0
            }
            /**
             The current mode the mower is in
             - returns: Mode and mode code as value of the enumeration.
             */
            public var mode : RobonectAPI.ModeCode {
                return RobonectAPI.ModeCode(rawValue: serverResponseStatus["mode"] as? Int ?? -1) ?? .unknown
            }
            /**
             The current battery level
             - returns: Battery level in percent
             */
            public var battery : Int {
                return serverResponseStatus["battery"] as? Int ?? 0
            }
            /**
             Total duration the mower was mowing
             - returns: Duration in hours
             */
            public var hours : Int {
                return serverResponseStatus["hours"] as? Int ?? 0
            }
        }
        public struct Timer {
            private var serverResponseTimer : [ String : Any ]
            init(_ serverResponseTimer : [ String : Any ]?) {
                self.serverResponseTimer = serverResponseTimer ?? [ String : Any ]()
            }
            /**
             The timers current state.
             - returns: Status and status code as value of the enumeration.
             */
            public var status : RobonectAPI.TimerStatusCode {
                return RobonectAPI.TimerStatusCode(rawValue: serverResponseTimer["status"] as? Int ?? -1) ?? .unknown
            }
            /**
             Next scheduled mowing date
             - returns: Date object based on the Unix timestamp
             */
            public var next : Date? {
                guard let dictionaryNext = serverResponseTimer["next"] as? [ String : Any ], let unixTimestamp = dictionaryNext["unix"] as? Int else {
                    return nil
                }
                return Date(timeIntervalSince1970: Double(unixTimestamp))
            }
        }
        public struct WLAN {
            private var serverResponseWlan : [ String : Any ]
            init(_ serverResponseWlan : [ String : Any ]?) {
                self.serverResponseWlan = serverResponseWlan ?? [ String : Any ]()
            }
            /**
             Signal strength of the network connection
             - returns: Strength in dB
             */
            public var signal : Int {
                return serverResponseWlan["signal"] as? Int ?? 0
            }
        }
        public struct Error {
            private var serverResponseError : [ String : Any ]
            init(_ serverResponseError : [ String : Any ]?) {
                self.serverResponseError = serverResponseError ?? [ String : Any ]()
            }
            /**
             Error Code as specified by Husqvarna
             - returns: Error code as enum value
             */
            public var errorCode : RobonectAPI.ErrorCode {
                return RobonectAPI.ErrorCode(rawValue: serverResponseError["error_code"] as? Int ?? -1) ?? .unknown
            }
            /**
             Error message as supplied by Robonect
             - Error message in German
             */
            public var errorMessage : String? {
                return serverResponseError["error_message"] as? String
            }
            /**
             First error date and time
             - returns: Date object based on the Unix timestamp
             */
            public var date : Date? {
                guard let unix = serverResponseError["unix"] as? Int else {
                    return nil
                }
                return Date(timeIntervalSince1970: Double(unix))
            }
        }
    }
}
