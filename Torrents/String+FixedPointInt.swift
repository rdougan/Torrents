//
//  String+FixedPointInt.swift
//  money
//
//  Created by Robert Dougan on 19/09/15.
//  Copyright © 2015 Phyn3t. All rights reserved.
//

import Foundation

extension String {
    
    func toFixedPointIntValue() -> Int32 {
        let split = self.componentsSeparatedByString(",")
        
        let largeString: String = split.first!
        let large: Int32 = (largeString as NSString).intValue * 100
        
        var smallString: String
        var small: Int32 = 0
        if (split.count > 1) {
            smallString = split.last!
            
            if ((smallString as NSString).length == 1) {
                small = (smallString as NSString).intValue * 10
            }
            else {
                small = (smallString as NSString).intValue
            }
        }
        
        return large + small
    }
    
}