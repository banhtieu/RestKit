//
//  InitableClass.swift
//  RestKit
//
//  Created by Tran Thien Khiem on 8/25/15.
//  Copyright © 2015 Tran Thien Khiem. All rights reserved.
//

import Foundation

class InitableClass: Initable {
    
    var value: Int
    
    required init() {
        value = 5
        print("Init")
    }
}
