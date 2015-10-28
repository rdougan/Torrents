//
//  NSDecimal.swift
//  money
//
//  Created by Robert Dougan on 01/10/15.
//  Copyright © 2015 Phyn3t. All rights reserved.
//

import Foundation

extension NSDecimal {
    
    var doubleValue: Double {
        get {
            let decimalNumber = NSDecimalNumber(decimal: self)
            return decimalNumber.doubleValue
        }
    }
    
}