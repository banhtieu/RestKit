//
//  Array+Serializable.swift
//  RestKit
//
//  Created by Tran Thien Khiem on 8/25/15.
//  Copyright © 2015 Tran Thien Khiem. All rights reserved.
//

import Foundation

extension Array: Serializable {

    // deserializable
    public mutating func deserialize(data: AnyObject) throws {
        
        removeAll()
        
        // if data is array of object
        if let array = data as? [AnyObject] {
            
            for item in array {
                if let type = Element.self as? Initable.Type {
                    let object = type.init()
                    if var serializable = object as? Serializable {
                        try serializable.deserialize(item)
                        
                        if let newElement = serializable as? Element {
                            append(newElement)
                        }
                    }
                }
            }
            
        } else {
            throw SerializingError.InvalidData
        }
    }
    
}
