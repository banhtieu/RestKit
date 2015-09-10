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
public class RestKit: NSObject, HttpClient {

    ///
    /// the url session
    var session: NSURLSession
    
    ///
    ///
    /// the request serializer
    var requestSerializer: RequestSerializer
    
    
    ///
    /// initialize a RestKit Client
    ///
    public required override init() {
        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        session = NSURLSession(configuration: sessionConfiguration)
        requestSerializer = DefaultRequestSerializer()
        
        super.init()
        
    }
    
    /// 
    /// start exectuting a request
    /// request(.GET, "")
    /// - parameter method: the request method
    /// - parameter url: the url request
    /// - parameter parameters: the parameters
    /// - returns: the request
    ///
    public func request(method: HttpMethod,
                        url: String,
                        parameters: AnyObject? = nil) -> Request {
        let request = Request()
        request.method = method
        request.endPoint = url
        request.client = self
        request.parameters = parameters            
        return request
    }
    
    ///
    /// execute the request
    /// - parameter requestData: the request Data
    public func execute(requestData: Request) {
        
        let request = requestSerializer.serialize(requestData)
        requestData.task = session.dataTaskWithRequest(request) {
            (data, response, error) in
            
            if let responseData = response,
                let resultData = data {
                requestData.okHandler?(response: responseData, data: resultData)
            } else {
                requestData.errorHandler?(error: error!)
            }
        }
        
        requestData.task?.resume()
        
        
        
    }
}
