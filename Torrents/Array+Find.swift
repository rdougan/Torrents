//
//  Array+Find.swift
//  money
//
//  Created by Robert Dougan on 18/09/15.
//  Copyright © 2015 Phyn3t. All rights reserved.
//

import Foundation

extension Array {
    
    func find(includedElement: Element -> Bool) -> Int? {
        for (idx, element) in self.enumerate() {
            if includedElement(element) {
                return idx
            }
        }
        
        return nil
    }
    
}