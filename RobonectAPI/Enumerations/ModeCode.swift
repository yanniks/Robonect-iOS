//
//  ModeCode.swift
//  Robonect
//
//  Created by Yannik Ehlert on 03.06.17.
//  Copyright © 2017 Yannik Ehlert. All rights reserved.
//

import Foundation

public extension RobonectAPI {
    public enum ModeCode: Int {
        case auto = 0
        case manual = 1
        case home = 2
        case demo = 3
        case unknown = -1
    }
}
