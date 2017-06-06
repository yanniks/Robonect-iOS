//
//  Integer.swift
//  Robonect
//
//  Created by Yannik Ehlert on 06.06.17.
//  Copyright © 2017 Yannik Ehlert. All rights reserved.
//

import Foundation

public extension Int {
    public var toHoursMinutesSeconds : (Int, Int, Int) {
        return (self / 3600, (self % 3600) / 60, (self % 3600) % 60)
    }
}
