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
    public var username: String?
    public var password: String?
    
    /**
     URL used for accessing the Robonect API
     - returns: URL String ready for use
     */
    public var url: String {
        let customPort = ssl ? (port == 443 ? false : true) : (port == 80 ? false : true)
        return (ssl ? "https" : "http") + "://" + hostname + (customPort ? (":" + String(port)) : "") + "/json"
    }
    public init(hostname: String, ssl: Bool = false, port: Int = 80, username: String? = nil, password: String? = nil) {
        self.hostname = hostname
        self.ssl = ssl
        self.port = port
        self.username = username
        self.password = password
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
