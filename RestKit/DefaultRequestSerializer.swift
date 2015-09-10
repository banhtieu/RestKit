//
//  DefaultRequestSerializer.swift
//  RestKit
//
//  Created by Tran Thien Khiem on 8/27/15.
//  Copyright © 2015 Tran Thien Khiem. All rights reserved.
//

import Foundation

///
/// Default request serializer
public class DefaultRequestSerializer: RequestSerializer {

    
    ///
    /// Serialize a Request to NSURLRequest
    ///
    /// - parameter data: request data
    ///
    /// - returns: NSURLRequest
    public func serialize(data: Request) -> NSURLRequest {
        
        let request = NSMutableURLRequest()
        request.HTTPMethod = data.method.rawValue
        var url = data.endPoint
        var serializeUrl = false
        
        if (data.method == HttpMethod.GET
            || data.method == HttpMethod.DELETE
            || data.method == HttpMethod.HEAD) {
            serializeUrl = true
            
            if let queryString = encodeParameters(data.parameters) {
                url = "\(url)?\(queryString)"
            }
        }
        
        // set URL
        request.URL = NSURL(string: url)
        
        // set headers
        for (headerField, value) in data.headers {
            request.setValue(value, forHTTPHeaderField: headerField)
        }
        
        if !serializeUrl {
            if data.encoding == Encoding.Url {
                request.setValue("application/x-www-form-urlencoded; charset=UTF-8", forHTTPHeaderField: "Content-Type")
                let encodedParameters = encodeParameters(data.parameters)
                request.HTTPBody = encodedParameters?.dataUsingEncoding(NSUTF8StringEncoding)
            } else if data.encoding == Encoding.Json {
                if let parameters = data.parameters,
                    let bodyAsJson = try? NSJSONSerialization.dataWithJSONObject(parameters, options: []) {
                    
                    request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
                    request.HTTPBody = bodyAsJson
                }
            }
        }
        
        return request
    }
    
    ///
    /// encode parameters into a string
    /// - parameter parameters: the parameter to encode
    /// - returns: string value
    func encodeParameters(parameters: Any?) -> String? {
        
        var result: String? = nil

        if let query = parameters as? [String: Any] {
            result = ""
            
            for (fieldName, value) in query {
                let escapedValue = "\(value)".stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
                result = "\(result!)\(fieldName)=\(escapedValue)&"
            }
        }
        
        return result
        
    }
}
