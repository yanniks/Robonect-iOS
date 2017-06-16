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
//  StatusViewControllerTableViewDelegate.swift
//  Robonect
//
//  Created by Yannik Ehlert on 07.06.17.
//

import UIKit

extension StatusViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let view = rowContent(indexPath: indexPath)
        switch view {
        case .duration:
            durationView()
        case .mode:
            modeSelection()
        case .error:
            askErrorReset()
        default:
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
    }
    private func askErrorReset() {
        let alert = UIAlertController(title: "Reset error", message: "Would you like to reset the current error?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default) { _ in
            NetworkingRequest.resetError(mower: SharedSettings.shared.mower) { callback in
                DispatchQueue.main.async {
                    ShowMessage.showMessage(message: callback.isSuccessful ? .modeAccepted : .actionFailed)
                }
            }
        })
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    private func modeSelection() {
        let alert = UIAlertController(title: "Select mode", message: "Please select your preferred mode.", preferredStyle: .actionSheet)
        let modes = [RobonectAPI.ModeCode.auto, RobonectAPI.ModeCode.manual, RobonectAPI.ModeCode.endOfDay, RobonectAPI.ModeCode.home]
        for mode in modes {
            alert.addAction(UIAlertAction(title: mode.localized, style: .default) { action in
                NetworkingRequest.set(mode: mode, mower: SharedSettings.shared.mower) { callback in
                    DispatchQueue.main.async {
                        ShowMessage.showMessage(message: callback.isSuccessful ? .modeAccepted : .actionFailed)
                    }
                }
            })
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    private func durationView() {
        let storyboard = UIStoryboard(name: "ProgressBarViews", bundle: nil)
        navigationController?.pushViewController(storyboard.instantiateViewController(withIdentifier: "engines") as! EngineViewController, animated: true)
    }
}
