//
//  Array+Remove.swift
//  money
//
//  Created by Robert Dougan on 22/09/15.
//  Copyright © 2015 Phyn3t. All rights reserved.
//

import Foundation

extension Array where Element : Equatable {
    
    mutating func remove(object: Generator.Element) {
        if let index = self.indexOf(object) {
            self.removeAtIndex(index)
        }
    }
    
}