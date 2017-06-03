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
    }
}
