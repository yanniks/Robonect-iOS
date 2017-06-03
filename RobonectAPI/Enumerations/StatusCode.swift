//
//  StatusCode.swift
//  Robonect
//
//  Created by Yannik Ehlert on 03.06.17.
//  Copyright © 2017 Yannik Ehlert. All rights reserved.
//

import Foundation

public extension RobonectAPI {
    public enum StatusCode: Int {
        case unknown = 0
        case park = 1
        case mow = 2
        case locateCharingStation = 3
        case charge = 4
        case search = 5
        case error = 7
        case signalLost = 8
        case off = 16
        case sleep = 17
    }
}
