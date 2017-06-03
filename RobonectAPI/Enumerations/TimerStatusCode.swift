//
//  TimerStatusCode.swift
//  Robonect
//
//  Created by Yannik Ehlert on 03.06.17.
//  Copyright © 2017 Yannik Ehlert. All rights reserved.
//

import Foundation

public extension RobonectAPI {
    public enum TimerStatusCode: Int {
        case deactivated = 0
        case active = 1
        case standby = 2
        case unknown = -1
    }
}
