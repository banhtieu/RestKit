//
//  FactoryTest.swift
//  RestKit
//
//  Created by Tran Thien Khiem on 8/25/15.
//  Copyright © 2015 Tran Thien Khiem. All rights reserved.
//

import XCTest

class FactoryTest: XCTestCase {

    ///
    /// test initable
    ///
    func testInitable() {
        let instance: InitableClass = Factory.get()
        assert(instance.value == 5, "mal-functioned Returned object")
        
        instance.value = 10
        let anotherInstance = Factory.get() as InitableClass
        assert(anotherInstance.value == 10, "must not create two objects")
    }
    
    
    ///
    /// test initable struct
    ///
    func testInitableStruct() {
        var instance: InitableStruct = Factory.get()
        assert(instance.value == 5, "mal-functioned Returned object")
        
        instance.value = 10
        let anotherInstance = Factory.get() as InitableStruct
        assert(anotherInstance.value == 5, "must create two objects")
    }
    
    ///
    /// test not initable
    ///
    func testNotinitable() {
        if let instance: NotInitableClass = Factory.get() {
            assertionFailure("\(instance) must be null")
        }
    }
    
    
    ///
    /// test register
    ///
    func testRegister() {
        Factory.register(NotInitableClass(value: 10))
        let instance: NotInitableClass = Factory.get()!
        assert(instance.value == 10, "Value is not 10")
    }
}
