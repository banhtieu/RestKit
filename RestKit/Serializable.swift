//
//  Serializable.swift
//  RestKit
//
//  Created by Tran Thien Khiem on 8/25/15.
//  Copyright © 2015 Tran Thien Khiem. All rights reserved.
//

import Foundation

///
/// Error while serialize/deserialize
///
enum SerializingError: ErrorType {
   
    ///
    /// invalid json
    case InvalidJSON
    
    ///
    /// invalid type
    case InvalidData
}

///
/// This protocol gives class 
/// the ability to initialize 
/// and set value from a dictionary
///
public protocol Serializable: Initable {
    
    ///
    /// set value
    ///
    /// - parameter data: input json data
    mutating func deserialize(data: AnyObject) throws
    
}
