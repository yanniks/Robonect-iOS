//
//  RobonectAPIResponseStatus.swift
//  Robonect
//
//  Created by Yannik Ehlert on 03.06.17.
//  Copyright © 2017 Yannik Ehlert. All rights reserved.
//

import Foundation

public extension RobonectAPIResponse {
    public struct Status {
        private let serverResponse : [ String : Any ]
        public let status : Status
        public let timer : Timer
        public let wlan : WLAN
        public init(serverResponse : [ String : Any ]) {
            self.serverResponse = serverResponse
            status = Status(serverResponse["status"] as? [ String : Any ])
            timer = Timer(serverResponse["timer"] as? [ String : Any ])
            wlan = WLAN(serverResponse["wlan"] as? [ String : Any ])
        }
        public var successful: Bool {
            return serverResponse["successful"] as? Bool ?? false
        }
        public var name: String? {
            return serverResponse["name"] as? String
        }
        
        public struct Status {
            private let serverResponseStatus : [ String : Any ]
            init(_ serverResponseStatus : [ String : Any ]?) {
                self.serverResponseStatus = serverResponseStatus ?? [ String : Any ]()
            }
            public var status : RobonectAPI.StatusCode {
                return RobonectAPI.StatusCode(rawValue: serverResponseStatus["status"] as? Int ?? 0) ?? .unknown
            }
            public var duration : Int {
                return serverResponseStatus["duration"] as? Int ?? 0
            }
            public var mode : RobonectAPI.ModeCode {
                return RobonectAPI.ModeCode(rawValue: serverResponseStatus["mode"] as? Int ?? -1) ?? .unknown
            }
            public var battery : Int {
                return serverResponseStatus["battery"] as? Int ?? 0
            }
            public var hours : Int {
                return serverResponseStatus["hours"] as? Int ?? 0
            }
        }
        public struct Timer {
            private var serverResponseTimer : [ String : Any ]
            init(_ serverResponseTimer : [ String : Any ]?) {
                self.serverResponseTimer = serverResponseTimer ?? [ String : Any ]()
            }
            public var status : RobonectAPI.TimerStatusCode {
                return RobonectAPI.TimerStatusCode(rawValue: serverResponseTimer["status"] as? Int ?? -1) ?? .unknown
            }
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
            public var signal : Int {
                return serverResponseWlan["signal"] as? Int ?? 0
            }
        }
    }
}
