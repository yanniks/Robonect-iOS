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
//  Mower.swift
//  Robonect
//
//  Created by Yannik Ehlert on 04.06.17.
//  Copyright © 2017 Yannik Ehlert. All rights reserved.
//

import Foundation

public class Mower {
    public var hostname: String
    public var ssl: Bool
    public var port: Int
    public var name: String?
    public var username: String?
    public var password: String?
    
    private var baseUrl: String {
        let customPort = ssl ? (port == 443 ? false : true) : (port == 80 ? false : true)
        return (ssl ? "https" : "http") + "://" + hostname + (customPort ? (":" + String(port)) : "")
    }
    /**
     URL used for accessing the Robonect API
     - returns: URL String ready for use
     */
    public var url: String {
        return baseUrl + "/json"
    }
    public var ajaxUrl: String {
        return baseUrl + "/ajax"
    }
    public init(hostname: String, ssl: Bool = false, port: Int = 80, username: String? = nil, password: String? = nil, name: String? = nil) {
        self.hostname = hostname
        self.ssl = ssl
        self.port = port
        self.username = username
        self.password = password
        self.name = name
    }
    /**
     Create a Mower object based on a passed URL
     */
    public static func createMower(url passedUrl: String) -> Mower? {
        let url = URL(string: passedUrl)
        if let host = url?.host {
            let ssl = url?.scheme == "https" ? true : false
            return Mower(hostname: host, ssl: ssl, port: url?.port ?? (ssl ? 443 : 80), username: url?.user, password: url?.password)
        }
        return nil
    }
}
