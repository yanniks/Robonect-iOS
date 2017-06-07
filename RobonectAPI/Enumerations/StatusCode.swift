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
//  StatusCode.swift
//  Robonect
//
//  Created by Yannik Ehlert on 03.06.17.
//  Copyright © 2017 Yannik Ehlert. All rights reserved.
//

import Foundation

public extension RobonectAPI {
    /**
     Status enumeration with all codes returned by the module. German explanations, copied from the documentation:
     - Unknown: Status wird ermittelt
     - Park: Automower parkt
     - Mow: Automower mäht
     - LocateChargingStation: Automower sucht die Ladestation
     - Charge: Automower lädt
     - Search: Automower sucht (wartet auf das Umsetzen im manuellen Modus)
     - Error: Fehlerstatus
     - SignalLost: Schleifensignal verloren
     - Off: Automower abgeschaltet
     - Sleep: Automower schläft
     */
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
