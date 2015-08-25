//
//  NotInitableClass.swift
//  RestKit
//
//  Created by Tran Thien Khiem on 8/25/15.
//  Copyright © 2015 Tran Thien Khiem. All rights reserved.
//

import Foundation

class NotInitableClass: NSObject {

    var value: Int
    
    init(value aValue: Int) {
        value = aValue
    }
}
