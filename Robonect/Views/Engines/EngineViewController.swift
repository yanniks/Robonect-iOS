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
//  EngineViewController.swift
//  Robonect
//
//  Created by Yannik Ehlert on 07.06.17.
//

import UIKit

class EngineViewController: UIViewController {
    @IBOutlet weak var labelPowerStageLeft: UILabel!
    @IBOutlet weak var labelPowerStageRight: UILabel!
    @IBOutlet weak var labelSpeedLeft: UILabel!
    @IBOutlet weak var labelSpeedRight: UILabel!
    @IBOutlet weak var labelCurrentLeft: UILabel!
    @IBOutlet weak var labelCurrentRight: UILabel!
    @IBOutlet weak var labelBladeMotorSpeed: UILabel!
    @IBOutlet weak var labelBladeMotorCurrent: UILabel!
    
    
    @IBOutlet weak var progressPowerStageLeft: UIProgressView!
    @IBOutlet weak var progressPowerStageRight: UIProgressView!
    @IBOutlet weak var progressSpeedLeft: UIProgressView!
    @IBOutlet weak var progressSpeedRight: UIProgressView!
    @IBOutlet weak var progressCurrentLeft: UIProgressView!
    @IBOutlet weak var progressCurrentRight: UIProgressView!
    @IBOutlet weak var progressBladeMotorSpeed: UIProgressView!
    @IBOutlet weak var progressBladeMotorCurrent: UIProgressView!
    
    
    @IBOutlet weak var valuePowerStageLeft: UILabel!
    @IBOutlet weak var valuePowerStageRight: UILabel!
    @IBOutlet weak var valueSpeedLeft: UILabel!
    @IBOutlet weak var valueSpeedRight: UILabel!
    @IBOutlet weak var valueCurrentLeft: UILabel!
    @IBOutlet weak var valueCurrentRight: UILabel!
    @IBOutlet weak var valueBladeMotorSpeed: UILabel!
    @IBOutlet weak var valueBladeMotorCurrent: UILabel!
    
    private var engine : RobonectAPIResponse.Engine? = nil
    private var timer : Timer? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Engines"
        fetchData()
    }
    func fetchData() {
        NetworkingRequest.fetchEngine(mower: SharedSettings.shared.mower) { callback in
            if !callback.isSuccessful {
                ShowMessage.showMessage(message: .actionFailed)
            }
            if let engine = callback.value {
                self.engine = engine
                DispatchQueue.main.async {
                    self.updateValues()
                }
            }
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.invalidate()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(EngineViewController.fetchData), userInfo: nil, repeats: true)
    }
    func updateValues() {
        progressPowerStageLeft.progress = abs(Float(engine?.pdrvpercentl ?? 0) / 100)
        valuePowerStageLeft.text = String(engine?.pdrvpercentl ?? 0) + " %"
        progressPowerStageRight.progress = abs(Float(engine?.pdrvpercentr ?? 0) / 100)
        valuePowerStageRight.text = String(engine?.pdrvpercentr ?? 0) + " %"
        
        progressSpeedLeft.progress = abs(Float(engine?.pdrvspeedl ?? 0) / 100)
        valueSpeedLeft.text = String(engine?.pdrvspeedl ?? 0) + " cm/s"
        progressSpeedRight.progress = abs(Float(engine?.pdrvspeedr ?? 0) / 100)
        valueSpeedRight.text = String(engine?.pdrvspeedr ?? 0) + " cm/s"
        
        progressCurrentLeft.progress = abs(Float(engine?.pdrvcurrentl ?? 0) / 100) * 0.2
        valueCurrentLeft.text = String(engine?.pdrvcurrentl ?? 0) + " mA"
        progressCurrentRight.progress = abs(Float(engine?.pdrvcurrentr ?? 0) / 100) * 0.2
        valueCurrentRight.text = String(engine?.pdrvcurrentr ?? 0) + " mA"
        
        progressBladeMotorSpeed.progress = abs(Float(engine?.pcutspeed ?? 0) / 100) * 0.02843439534
        valueBladeMotorSpeed.text = String(engine?.pcutspeed ?? 0) + " RPM"
        progressBladeMotorCurrent.progress = abs(Float(engine?.pcutcurrent ?? 0) / 100) * 0.2
        valueBladeMotorCurrent.text = String(engine?.pcutcurrent ?? 0) + " mA"
    }
}
