//
//  StatusViewControllerTableViewDataSource.swift
//  Robonect
//
//  Created by Yannik Ehlert on 06.06.17.
//  Copyright © 2017 Yannik Ehlert. All rights reserved.
//

import UIKit

private enum StatusViewEnum {
    case mode, duration, next, wlan, unknown, error
}

extension StatusViewController: UITableViewDataSource {
    private func rowContent(indexPath: IndexPath) -> StatusViewEnum {
        var row = indexPath.row
        if let _ = response?.error.errorMessage {
            if row == 0 {
                return .error
            }
        } else {
            row += 1
        }
        if let _ = response?.status.mode {
            if row == 1 {
                return .mode
            }
        } else {
            row += 1
        }
        if let _ = response?.status.duration {
            if row == 2 {
                return .duration
            }
        } else {
            row += 1
        }
        if let _ = response?.timer.next {
            if row == 3 {
                return .next
            }
        } else {
            row += 1
        }
        if let _ = response?.wlan.signal {
            if row == 4 {
                return .wlan
            }
        } else {
            row += 1
        }
        return .unknown
    }
    private var numerOfRows: Int {
        var cnt = 0
        if let _ = response?.error.errorMessage {
            cnt += 1
        }
        if let _ = response?.status.mode {
            cnt += 1
        }
        if let _ = response?.status.duration {
            cnt += 1
        }
        if let _ = response?.timer.next {
            cnt += 1
        }
        if let _ = response?.wlan.signal {
            cnt += 1
        }
        return cnt
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numerOfRows
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "statuscell") as? StatusViewCell else {
            return UITableViewCell()
        }
        let content = rowContent(indexPath: indexPath)
        if content == .error {
            cell.imageIcon.image = UIImage.fontAwesomeIcon(name: .exclamation, textColor: .white, size: CGSize(width: 40, height: 40))
            if let errorMessage = response?.error.errorMessage {
                cell.textDescription.text = errorMessage
            } else {
                cell.textDescription.text = "No error"
            }
        } else if content == .mode {
            cell.imageIcon.image = UIImage.fontAwesomeIcon(name: .compass, textColor: .white, size: CGSize(width: 40, height: 40))
            if let mode = response?.status.mode {
                cell.textDescription.text = mode.localized
            } else {
                cell.textDescription.text = "Unknown"
            }
        } else if content == .duration {
            cell.imageIcon.image = UIImage.fontAwesomeIcon(name: .clockO, textColor: .white, size: CGSize(width: 40, height: 40))
            if let duration = response?.status.duration {
                let (h,m,_) = duration.toHoursMinutesSeconds
                cell.textDescription.text = "\(h) hours, \(m) minutes"
            } else {
                cell.textDescription.text = "Unknown"
            }
        } else if content == .next {
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
        } else if content == .wlan {
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
