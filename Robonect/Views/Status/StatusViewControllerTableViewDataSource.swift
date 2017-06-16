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
//  StatusViewControllerTableViewDataSource.swift
//  Robonect
//
//  Created by Yannik Ehlert on 06.06.17.
//  Copyright © 2017 Yannik Ehlert. All rights reserved.
//

import UIKit
import FontAwesome_swift

internal enum StatusViewEnum {
    case mode, duration, next, wlan, unknown, error
}

extension StatusViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numerOfRows
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "statuscell") as? StatusViewCell else {
            return UITableViewCell()
        }
        let view = rowContent(indexPath: indexPath)
        let (fa, height, description) = contentForView(view)
        cell.imageIcon.image = UIImage.fontAwesomeIcon(name: fa, textColor: .white, size: CGSize(width: height, height: height))
        cell.textDescription.text = description
        return cell
    }
    
    /**
     Determines which content to display in which row
     */
    internal func rowContent(indexPath: IndexPath) -> StatusViewEnum {
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
    /**
     Determines how many rows exist in the TableView
     */
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
    /**
     Generates the content for a certain view category.
     - returns: FontAwesome icon, the height for that icon and the description for the TableViewCell.
     */
    private func contentForView(_ view: StatusViewEnum) -> (FontAwesome, Int, String) {
        switch view {
        case .error:
            return (.exclamation, 40, response?.error.errorMessage ?? "No error")
        case .mode:
            return (.compass, 40, response?.status.mode.localized ?? "Unknown")
        case .duration:
            if let duration = response?.status.duration {
                let (h,m,_) = duration.toHoursMinutesSeconds
                return (.clockO, 40, "\(h) hours, \(m) minutes")
            }
            return (.clockO, 40, "Unknown")
        case .next:
            let df = DateFormatter()
            df.timeZone = TimeZone(abbreviation: "UTC")
            df.dateStyle = .long
            df.timeStyle = .short
            if let next = response?.timer.next {
                return (.arrowRight, 40, df.string(from: next))
            } else {
                return (.arrowRight, 40, "Unknown")
            }
        case .wlan:
            return (.wifi, 35, response?.wlan.signal != nil ? String(response?.wlan.signal ?? 0) + " dB" : "Unknown")
        default:
            return (.question, 40, "")
        }
    }
}
