//
//  BasicType+Serializable.swift
//  RestKit
//
//  Created by Tran Thien Khiem on 8/25/15.
//  Copyright © 2015 Tran Thien Khiem. All rights reserved.
//

import Foundation


/// extension for all basic types
extension String: Serializable, Initable {
    
    ///
    /// deserialize an object to string
    ///
    public mutating func deserialize(data: AnyObject) throws {
        self = "\(data)"
    }
}

/// extension for Int
extension Int: Serializable, Initable {
    
    ///
    /// deserialize for integer
    public mutating func deserialize(data: AnyObject) throws {
        if let intValue = data as? Int {
            self = intValue
        } else {
            throw SerializingError.InvalidData
        }
    }
}

/// extension for Bool
extension Bool: Serializable, Initable {
    public mutating func deserialize(data: AnyObject) throws {
        if let boolValue = data as? Bool {
            self = boolValue
        } else {
            throw SerializingError.InvalidJSON
        }
    }
}

/// extension for Bool
extension Float: Serializable, Initable {
    public mutating func deserialize(data: AnyObject) throws {
        if let floatValue = data as? Float {
            self = floatValue
        } else {
            throw SerializingError.InvalidJSON
        }
    }
}

/// extension for Bool
extension Double: Serializable, Initable {
    public mutating func deserialize(data: AnyObject) throws {
        if let doubleValue = data as? Double {
            self = doubleValue
        } else {
            throw SerializingError.InvalidJSON
        }
    }
}
