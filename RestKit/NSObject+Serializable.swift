//
//  AnyObject+Serializable.swift
//  RestKit
//
//  Created by Tran Thien Khiem on 8/25/15.
//  Copyright © 2015 Tran Thien Khiem. All rights reserved.
//

import Foundation

///
/// Serializable support for NSObject
///
extension NSObject: Serializable, Initable {
    
    ///
    /// deserialize an NSObject from 
    /// a json string
    public func deserialize(data: AnyObject) throws {
        
        // cast to String -> AnyObject
        if let dictionary = data as? [String: AnyObject] {
            
            // going through all data
            let mirror = Mirror(reflecting: self)
            
            // see value
            for (label, value) in mirror.children {
                if let propertyName = label,
                   let dataObject = dictionary[propertyName],
                   var serializableObject = value as? Serializable {
                    try serializableObject.deserialize(dataObject)
                    setValue(serializableObject as? AnyObject, forKey: propertyName)
                }
            }
            
        } else {
            throw SerializingError.InvalidData
        }
    }
    
}

