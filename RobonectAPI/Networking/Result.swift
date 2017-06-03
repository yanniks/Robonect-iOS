//
//  Result.swift
//  Robonect
//
//  Created by Yannik Ehlert on 03.06.17.
//  Copyright © 2017 Yannik Ehlert. All rights reserved.
//

import Foundation

public struct Result<Value> {
    public let request: URLRequest?
    public let response: URLResponse?
    public let error: Error?
    public let value: Value?
    public var isSuccessful: Bool {
        return error == nil && value != nil
    }
    public init(_ request: URLRequest?, response: URLResponse?, error: Error?, value: Value?) {
        self.request = request
        self.response = response
        self.error = error
        self.value = value
    }
}
