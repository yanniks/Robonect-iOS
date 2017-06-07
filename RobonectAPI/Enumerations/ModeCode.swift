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
//  ModeCode.swift
//  Robonect
//
//  Created by Yannik Ehlert on 03.06.17.
//  Copyright © 2017 Yannik Ehlert. All rights reserved.
//

import Foundation

public extension RobonectAPI {
    /**
     Mode enumeration with all codes returned by the module.
     - Auto: Automatic mode
     - Manual: Mower does not automatically return for charging. Keeps mowing until battery is empty.
     - Home: Mower stays in the charging station. If it is mowing, it stops immediately and returns back home.
     - Demo
     - Unknown: Unsupported response received.
     */
    public enum ModeCode: Int {
        case auto = 0
        case manual = 1
        case home = 2
        case demo = 3
        case unknown = -1
        case startMowing = 97
        case endOfDay = 98
        case job = 99
        
        /**
         Value used when setting mode.
         */
        public var stringValue: String {
            switch self {
            case .auto:
                return "auto"
            case .manual:
                return "man"
            case .home:
                return "home"
            case .endOfDay:
                return "eod"
            case .job:
                return "job"
            default:
                return ""
            }
        }
        /**
         Value that is relevant when setting the *after* parameter when setting mode.
         */
        public var afterValue: Int {
            switch self {
            case .auto:
                return 4
            case .home:
                return 1
            case .endOfDay:
                return 2
            case .manual:
                return 3
            default:
                return -1
            }
        }
        /**
         Localized description of the mode
         */
        public var localized: String {
            switch self {
            case .auto:
                return "Automatic"
            case .demo:
                return "Demonstration"
            case .endOfDay:
                return "End of day"
            case .home:
                return "Home"
            case .job:
                return "Job"
            case .manual:
                return "Manual"
            case .startMowing:
                return "Start mowing"
            default:
                return "Unknown"
            }
        }
    }
}
