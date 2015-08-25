//
//  Factory.swift
//  RestKit
//
//  Created by Tran Thien Khiem on 8/25/15.
//  Copyright © 2015 Tran Thien Khiem. All rights reserved.
//

import Foundation

///
/// Factory of *objects*
/// you can get instance of any object
/// by calling `Factory.get()`
///
public class Factory {

    
    ///
    /// array of *registered* objects
    ///
    private static var objects = [Any]()
    

    ///
    /// get an instance of `T` class
    ///
    /// - returns: an instance of `T`
    ///
    public static func get<T>() -> T? {
        
        var result: T?
        
        // search for objects
        for item in objects {
            if let data = item as? T {
                result = data
            }
        }
        
        return result
    }
    
    ///
    /// get an instance of `T` class
    ///
    /// - returns: an instance of `T`
    ///
    public static func get<T: Initable>() -> T {
        
        var result: T!
        
        if let item: T = get() {
            result = item
        }
        
        // if result is nil then get it
        if result == nil {
            result = T()
            
            register(result as Any)
        }
        
        return result
    }
    
    ///
    /// registered an object to the factory
    ///
    /// - parameter instance: the object to register
    ///
    public static func register(instance: Any) {
        objects.append(instance)
    }
}
