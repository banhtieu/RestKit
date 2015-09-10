//
//  RequestTest.swift
//  RestKit
//
//  Created by Tran Thien Khiem on 9/10/15.
//  Copyright © 2015 Tran Thien Khiem. All rights reserved.
//

import XCTest

class RequestTest: XCTestCase {
    
    func testExample() {
        
        let requestOKExpectation = expectationWithDescription("Request Finished")
        
        let client: RestKit = Factory.get()
        
        client.request(.GET, url: "http://www.google.com")
            .onOK {
            (text: String) in
                
            print(text)
            requestOKExpectation.fulfill()
        } .execute()
        
        waitForExpectationsWithTimeout(10, handler: {
            error in
        })
    }
    
}
