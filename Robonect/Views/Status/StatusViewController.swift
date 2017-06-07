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
//  StatusViewController.swift
//  Robonect
//
//  Created by Yannik Ehlert on 06.06.17.
//  Copyright © 2017 Yannik Ehlert. All rights reserved.
//

import UIKit
import FontAwesome

class StatusViewController: UIViewController {
    // Labels and ImageViews used for the header
    @IBOutlet weak var labelMowerName: UILabel!
    @IBOutlet weak var labelStatus: UILabel!
    @IBOutlet weak var labelBattery: UILabel!
    @IBOutlet weak var imageViewStatus: UIImageView!
    
    @IBOutlet weak var infoTableView: UITableView!
    var response : RobonectAPIResponse.Status? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        infoTableView.refreshControl = UIRefreshControl()
        infoTableView.refreshControl?.addTarget(self, action: #selector(StatusViewController.updateContent), for: .valueChanged)
        updateContent()
    }
    func updateContent() {
        guard let mower = Mower.createMower(url: "http://mowerhostname") else {
            print("Mower object creation failed!")
            return
        }
        NetworkingRequest.sendStatusRequest(mower: mower) { callback in
            self.response = callback.value
            DispatchQueue.main.async {
                self.infoTableView.refreshControl?.endRefreshing()
                self.updateHeaderSection()
                self.infoTableView.reloadData()
            }
        }
    }
    func updateHeaderSection() {
        // Update the mowers name as transmitted by Robonect
        labelMowerName.text = response?.name ?? "Unknown name"
        
        // Update the mowers state
        var textStatus = "Unknown"
        var color = UIColor.robonectStatusRed
        if let status = response?.status.status {
            color = UIColor.robonectStatusGreen
            switch status {
            case .mow:
                imageViewStatus.image = UIImage(named: "mower_active")
                textStatus = "Mowing"
                break
            case .charge:
                imageViewStatus.image = UIImage(named: "mower_charging")
                textStatus = "Charging"
                break
            case .park:
                textStatus = "Parking"
                break
            case .sleep:
                imageViewStatus.image = UIImage(named: "mower_default")
                textStatus = "Sleeping"
                break
            case .error:
                imageViewStatus.image = UIImage(named: "mower_attention")
                color = UIColor.robonectStatusRed
                textStatus = "Error mode"
                break
            default:
                break
            }
        } else {
            imageViewStatus.image = UIImage(named: "mower_attention")
        }
        imageViewStatus.backgroundColor = color
        labelStatus.text = "Status: " + textStatus
        
        if let battery = response?.status.battery {
            labelBattery.text = "Battery: " + String(battery) + " %"
        } else {
            labelBattery.text = "Battery: Unknown"
        }
    }
}
