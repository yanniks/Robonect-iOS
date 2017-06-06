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
    }
}
