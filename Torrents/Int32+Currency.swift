//
//  Int32+Currency.swift
//  money
//
//  Created by Robert Dougan on 18/09/15.
//  Copyright © 2015 Phyn3t. All rights reserved.
//

import Foundation

extension Int32 {
    
    func toCurrencyString() -> String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        
        let double = Double(self)
        let number = NSDecimalNumber(double: double / 100)
        return formatter.stringFromNumber(number)!
    }
    
}