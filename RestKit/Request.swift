//
//  RequestData.swift
//  RestKit
//
//  Created by Tran Thien Khiem on 8/26/15.
//  Copyright © 2015 Tran Thien Khiem. All rights reserved.
//

import Foundation

///
/// HTTP Method
public enum HttpMethod: String {
    case OPTIONS = "OPTIONS"
    case GET = "GET"
    case HEAD = "HEAD"
    case POST = "POST"
    case PUT = "PUT"
    case PATCH = "PATCH"
    case DELETE = "DELETE"
    case TRACE = "TRACE"
    case CONNECT = "CONNECT"
}

///
/// the client
public protocol HttpClient {
    func execute(request: Request)
}

///
/// Request Data - contains description of a request
public class Request {

    ///
    /// url to the end point
    public var endPoint = ""
    
    ///
    /// the method
    public var method = HttpMethod.GET
    
    ///
    /// the headers of the request
    public var headers = [String: String]()

    ///
    /// list of query parameters
    public var parameters: Any?
    
    ///
    /// the attachment
    public var attachments = [NSData]()
    
    ///
    /// the client 
    public var client: HttpClient?

    ///
    /// request is OK
    public var okHandler: ((response: NSURLResponse, data: NSData) -> Void)?
    
    ///
    /// handler when request is not OK
    public var errorHandler: ((error: ErrorType) -> Void)?
    
    ///
    /// initialize the object
    public init() {
        
    }
    
    ///
    /// set all parameters
    /// - parameter parameters: array of parameters
    /// - returns: this object for convinience
    public func setParameters(parameters: [String: Any]) -> Request {
        self.parameters = parameters
        
        return self
    }
    
    ///
    /// set header value
    ///
    /// - parameter key: name of the parameter
    /// - parameter value: value of the parameter
    /// - returns: this object for convinience
    public func setHeader(key: String, value: String) -> Request {
        headers[key] = value
        
        return self
    }
    
    
    ///
    /// set header value
    ///
    /// - parameter headers: array of headers
    /// - returns: this object for convinience
    public func setHeaders(headers: [String: String]) -> Request {
        self.headers = headers
        
        return self
    }
    
    ///
    /// attach a file from file system
    ///
    /// - parameter path: path to the file
    /// - returns: this object for convinience
    public func attachFile(path: String) -> Request {
        
        if  let url = NSURL(string: path),
            let data = NSData(contentsOfURL: url) {
            attachFile(data)
        }

        return self
    }
    
    ///
    /// attach a file from data
    ///
    /// - parameter data: content of the file
    /// - returns: this object for convinience
    public func attachFile(data: NSData) -> Request {
        
        attachments.append(data)
        
        return self
    }
    
    ///
    /// execute current request
    public func execute() -> Request {
        client?.execute(self)
        
        return self
    }
    
    ///
    /// handle when text is returned
    /// 
    /// param
    public func onRequestOK(handler: (text: String) -> Void) -> Request {
        
        okHandler = {
            response, data in
            let text = NSString(data: data, encoding: NSUTF8StringEncoding) as! String
            handler(text: text)
        }
        
        return self
    }
    
    
    ///
    /// request is OK
    /// get an object back
    ///
    /// - parameter handler: the handler
    /// - returns: this object for convinience
    ///
    public func onRequestOK<T: Serializable>(handler: (data: T) -> Void) -> Request {
        
        okHandler = {
            response, data in
            do {
                let objectData = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
                var object: T = T()
                try object.deserialize(objectData)
                
                handler(data: object)
            } catch let error {
                self.errorHandler?(error: error)
            }
        }
        
        return self
    }
    
    
    ///
    /// request is OK
    /// get NSData back
    /// - parameter handler: the data handler
    /// - returns: this object for convinience
    public func onRequestOK(handler: (data: NSData) -> Void) -> Request {
        okHandler = {
            response, data in
            handler(data: data)
        }
        
        return self
    }
    
    
}
