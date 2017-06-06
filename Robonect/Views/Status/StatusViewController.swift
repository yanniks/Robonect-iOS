//
//  StatusViewController.swift
//  Robonect
//
//  Created by Yannik Ehlert on 06.06.17.
//  Copyright © 2017 Yannik Ehlert. All rights reserved.
//

import UIKit
import FontAwesome

class StatusViewController: UIViewController, UITableViewDataSource {
    // Labels and ImageViews used for the header
    @IBOutlet weak var labelMowerName: UILabel!
    @IBOutlet weak var labelStatus: UILabel!
    @IBOutlet weak var labelBattery: UILabel!
    @IBOutlet weak var imageViewStatus: UIImageView!
    
    @IBOutlet weak var infoTableView: UITableView!
    var response : RobonectAPIResponse.Status? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let mower = Mower.createMower(url: "http://mowerhostname") else {
            print("Mower object creation failed!")
            return
        }
        NetworkingRequest.sendStatusRequest(mower: mower) { callback in
            self.response = callback.value
            DispatchQueue.main.async {
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
        if let status = response?.status.status {
            var color = UIColor.robonectStatusGreen
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
            imageViewStatus.backgroundColor = color
        }
        labelStatus.text = "Status: " + textStatus
        
        if let battery = response?.status.battery {
            labelBattery.text = "Battery: " + String(battery) + " %"
        } else {
            labelBattery.text = "Battery: Unknown"
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "statuscell") as? StatusViewCell else {
            return UITableViewCell()
        }
        if indexPath.row == 0 {
            cell.imageIcon.image = UIImage.fontAwesomeIcon(name: .clockO, textColor: .white, size: CGSize(width: 40, height: 40))
            if let duration = response?.status.duration {
                let (h,m,_) = duration.toHoursMinutesSeconds
                cell.textDescription.text = "\(h) hours, \(m) minutes"
            } else {
                cell.textDescription.text = "Unknown"
            }
        } else if indexPath.row == 1 {
            cell.imageIcon.image = UIImage.fontAwesomeIcon(name: .arrowRight, textColor: .white, size: CGSize(width: 40, height: 40))
            let df = DateFormatter()
            df.dateStyle = .long
            df.timeStyle = .short
            if let next = response?.timer.next {
                cell.textDescription.text = df.string(from: next)
            } else {
                cell.textDescription.text = "Unknown"
            }
        } else {
            cell.imageIcon.image = UIImage.fontAwesomeIcon(name: .wifi, textColor: .white, size: CGSize(width: 35, height: 35))
            if let wifiSignal = response?.wlan.signal {
                cell.textDescription.text = String(wifiSignal) + " dB"
            } else {
                cell.textDescription.text = "Could not fetch signal strength"
            }
        }
        return cell
    }
}
