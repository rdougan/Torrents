//
//  String+Trim.swift
//  money
//
//  Created by Robert Dougan on 18/09/15.
//  Copyright © 2015 Phyn3t. All rights reserved.
//

import Foundation

extension String {
    
    func trim() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
    
}