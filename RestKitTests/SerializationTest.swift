//
//  SerializationTest.swift
//  RestKit
//
//  Created by Tran Thien Khiem on 8/25/15.
//  Copyright © 2015 Tran Thien Khiem. All rights reserved.
//

import XCTest

class Sample: NSObject {
    var value: String = ""
}

class SerializationTest: XCTestCase {

    ///
    /// Test serializabel
    func testSerializeString() {
        
        var string = ""
        
        do {
            try string.deserialize("Hello world")
            assert(string == "Hello world", "Deserialize unsuccessful")
        } catch {
            assertionFailure("Cannot Deserialize")
        }
    }

    /// 
    /// Test serializable object
    func testSerializeObject() {
        let sample = Sample()
        let data = ["value": "Hello World"]
        
        do {
            try sample.deserialize(data)
            assert(sample.value == "Hello World", "Deserialize unsuccessful")
        } catch {
            assertionFailure("Cannot Deserialize")
        }
    }
    
    func testSerializeArray() {
        var sample = [Sample]()
        let data = [["value": "1"],
                    ["value": "2"]]
        
        do {
            try sample.deserialize(data)
            assert(sample.count == 2, "Array size doesn't match")
            assert(sample[0].value == "1", "First item must be 1")
            assert(sample[1].value == "2", "Second item must be 2")
            
        } catch {
            assertionFailure("Cannot deserialize")
        }
    }

}
