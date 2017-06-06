//
//  ErrorCode.swift
//  Robonect
//
//  Created by Yannik Ehlert on 06.06.17.
//  Copyright © 2017 Yannik Ehlert. All rights reserved.
//

import Foundation

public extension RobonectAPI {
    /**
     Enumeration of error codes. Based on http://www.robonect.de/viewtopic.php?f=30&t=930&p=7687&hilit=Fehlercodes#p7687
     */
    public enum ErrorCode: Int {
        case workAreaExceeded = 1
        case noLoopSignal = 2
        case loopSensorMalfunctionFront = 4
        case loopSensorMalfunctionBack = 5
        case loopSensorMalfunction = 6
        case wrongPinEntered = 8
        case mowerImpacted = 9
        case mowerTurned = 10
        case batteryLow = 11
        case batteryEmpty = 12
        case noDrive = 13
        case mowerLifted = 15
        case stuckInCharger = 16
        case chargerBlocked = 17
        case impactSensorMalfunctionFront = 18
        case impactSensorMalfunctionBack = 19
        case rightEngineBlocked = 20
        case leftEngineBlocked = 21
        case rightWeelMalfunction = 22
        case leftWheelMalfunction = 23
        case bladeMotorMalfunction = 24
        case mowingUnitBlocked = 25
        case settingsResetted = 27
        case storageCircuitProblem = 28
        case slopeTooSteep = 29
        case batteryProblem = 30
        case stopButtonProblem = 31
        case tiltSensorMalfunction = 32
        case mowerIsTilted = 33
        case rightEngineOverload = 35
        case leftEngineOverload = 36
        case currentTooHigh = 37
        case cuttingHeightAdjustmentBlocked = 42
        case unexpectedCuttingHeightAdjustment = 43
        case guideWireSKOneNotFound = 50
        case guideWireSKTwoNotFound = 51
        case guideWireSKThreeNotFound = 52
        case calibrationGuideWireEnded = 56
        case shorttermBatteryProblem = 58
        case batteryProblemTwo = 66
        case alarmMowerPoweredOff = 69
        case alarmMowerStopped = 70
        case mowerRaised = 71
        case mowerTilted = 72
        // In case the code is not known
        case unknown = -1
    }
}
