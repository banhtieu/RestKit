//
//  DataSerializer.swift
//  RestKit
//
//  Created by Tran Thien Khiem on 8/25/15.
//  Copyright © 2015 Tran Thien Khiem. All rights reserved.
//

import Foundation

/// serialize a request
public protocol RequestSerializer {

    ///
    /// serialize a HTTP Request
    ///
    /// - parameter data: the data to request
    /// - returns: NSURLRequest
    func serialize(data: Request) -> NSURLRequest
    
}
