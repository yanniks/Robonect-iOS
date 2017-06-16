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
//  ShowMessage.swift
//  Robonect
//
//  Created by Yannik Ehlert on 16.06.17.
//

import Foundation
import RMessage

public class ShowMessage {
    public enum NotificationMessageType: String {
        case mowerStarted = "Mower started"
        case mowerStopped = "Mower stopped"
        case actionFailed = "Action failed"
        case modeAccepted = "Mode accepted"
        case custom = "CUSTOM"
        var rmessageType: RMessageType {
            switch self {
            case .mowerStarted:
                return .success
            case .mowerStopped:
                return .success
            case .actionFailed:
                return .error
            case .modeAccepted:
                return .success
            default:
                return .normal
            }
        }
    }
    public static func showMessage(message: NotificationMessageType, customMessage: String? = nil) {
        let messageText : String? = message == .custom ? customMessage : message.rawValue
        RMessage.showNotification(withTitle: messageText, type: message.rmessageType, customTypeName: nil) { _ in
            
        }
        
    }
}
