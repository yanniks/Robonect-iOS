//
//  ErrorCode.swift
//  Robonect
//
//  Created by Yannik Ehlert on 06.06.17.
//  Copyright © 2017 Yannik Ehlert. All rights reserved.
//

import Foundation

public extension RobonectAPI {
    public enum ErrorCode: Int {
        case no = 0
        case invalidCmd = 1
        case missingParameter = 2
        case invalidParameter = 3
        case cmdFailed = 4
        case failureState = 5
        case alreadyRunning = 6
        case alreadyStopped = 7
        case timeout = 8
        case bumped = 9
        case shock = 10
        case noSignal = 11
        case nothingChanged = 12
        case notInFailureState = 13
        case notImplemented = 254
        case unspecified = 255
    }
}
