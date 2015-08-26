//
//  RestKit.swift
//  RestKit
//
//  Created by Tran Thien Khiem on 8/26/15.
//  Copyright © 2015 Tran Thien Khiem. All rights reserved.
//

import Foundation

///
/// Rest Kit
///
public class RestKit: HttpClient {

    
    /// 
    /// start exectuting a request
    /// request(.GET, "")
    ///
    public func request(method: HttpMethod,
                        url: String,
                        parameters: Any! = nil) -> Request {
        let request = Request()
        request.method = method
        request.client = self
        request.parameters = parameters            
        return request
    }
    
    ///
    /// execute the request
    public func execute(requestData: Request) {
    }
}
