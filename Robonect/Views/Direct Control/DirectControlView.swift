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
//  DirectControlView.swift
//  Robonect
//
//  Created by Yannik Ehlert on 16.06.17.
//

import UIKit
import MotionKit

class DirectControlView: UIViewController {
    private let motionkit = MotionKit()
    private var timer : Timer? = nil
    
    private var intEngineLeft = 0
    private var intEngineRight = 0
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        calculateMowerEngineValues()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        motionkit.stopDeviceMotionUpdates()
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    func calculateMowerEngineValues() {
        motionkit.getDeviceMotionObject(1.0) { dm in
            let pitch = dm.attitude.pitch * 57.2957795131
            let roll = dm.attitude.roll * 57.2957795131
            var left = -pitch
            var right = -pitch
            if roll < -1 {
                right *= 10/abs(roll)
            } else if roll > 1 {
                left *= 10/abs(roll)
            }
            left *= 2
            right *= 2
            self.intEngineRight = Int(left > 100 ? 100 : left)
            self.intEngineLeft = Int(right > 100 ? 100 : right)
            self.sendMowerSteeringRequest()
            print(self.intEngineLeft, self.intEngineRight)
        }
    }
    func sendMowerSteeringRequest() {
        // No update required if mower is not supposed to move
        if intEngineRight == 0 && intEngineLeft == 0 {
            return
        }
        NetworkingRequest.steer(left: intEngineLeft, right: intEngineRight, timeout: 1000, mower: SharedSettings.shared.mower) { callback in
            print(callback)
        }
    }
}
