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
//  RobonectAPIResponseEngine.swift
//  Robonect
//
//  Created by Yannik Ehlert on 07.06.17.
//

import Foundation

public extension RobonectAPIResponse {
    public struct Engine {
        private let serverResponse : [ String : Any ]
        public init(serverResponse : [ String : Any ]) {
            self.serverResponse = serverResponse
        }
        public var pdrvpercentl: Double {
            guard var internalValue = serverResponse["pdrvpercentl"] as? String else {
                return 0
            }
            internalValue = internalValue.substring(from: internalValue.characters.index(internalValue.startIndex, offsetBy: 3))
            return Double(internalValue.replacingOccurrences(of: "%", with: "")) ?? 0 / 100
        }
        public var pdrvpercentr: Double {
            guard var internalValue = serverResponse["pdrvpercentr"] as? String else {
                return 0
            }
            internalValue = internalValue.substring(from: internalValue.characters.index(internalValue.startIndex, offsetBy: 3))
            return Double(internalValue.replacingOccurrences(of: "%", with: "")) ?? 0 / 100
        }
        /**
         The left engines speed in cm/s
         */
        public var pdrvspeedl: Double {
            guard var internalValue = serverResponse["pdrvspeedl"] as? String else {
                return 0
            }
            internalValue = internalValue.substring(from: internalValue.characters.index(internalValue.startIndex, offsetBy: 3))
            return Double(internalValue.replacingOccurrences(of: "cm/s", with: "")) ?? 0
        }
        public var pdrvspeedr: Double {
            guard var internalValue = serverResponse["pdrvspeedr"] as? String else {
                return 0
            }
            internalValue = internalValue.substring(from: internalValue.characters.index(internalValue.startIndex, offsetBy: 3))
            return Double(internalValue.replacingOccurrences(of: "cm/s", with: "")) ?? 0
        }
        public var pdrvcurrentl: Double {
            guard var internalValue = serverResponse["pdrvcurrentl"] as? String else {
                return 0
            }
            internalValue = internalValue.substring(from: internalValue.characters.index(internalValue.startIndex, offsetBy: 3))
            return Double(internalValue.replacingOccurrences(of: "mA", with: "")) ?? 0
        }
        public var pdrvcurrentr: Double {
            guard var internalValue = serverResponse["pdrvcurrentr"] as? String else {
                return 0
            }
            internalValue = internalValue.substring(from: internalValue.characters.index(internalValue.startIndex, offsetBy: 3))
            return Double(internalValue.replacingOccurrences(of: "mA", with: "")) ?? 0
        }
        public var pcutspeed: Double {
            guard var internalValue = serverResponse["pcutspeed"] as? String else {
                return 0
            }
            internalValue = internalValue.substring(from: internalValue.characters.index(internalValue.startIndex, offsetBy: 3))
            return Double(internalValue.replacingOccurrences(of: "RPM", with: "")) ?? 0
        }
        public var pcutcurrent: Double {
            guard var internalValue = serverResponse["pcutcurrent"] as? String else {
                return 0
            }
            internalValue = internalValue.substring(from: internalValue.characters.index(internalValue.startIndex, offsetBy: 3))
            return Double(internalValue.replacingOccurrences(of: "mA", with: "")) ?? 0
        }
    }
}
