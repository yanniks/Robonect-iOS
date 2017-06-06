//
//  StatusViewControllerTableViewDataSource.swift
//  Robonect
//
//  Created by Yannik Ehlert on 06.06.17.
//  Copyright © 2017 Yannik Ehlert. All rights reserved.
//

import UIKit

extension StatusViewController: UITableViewDataSource {
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
            df.timeZone = TimeZone(abbreviation: "UTC")
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
