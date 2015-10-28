//
//  NSIndexSet+Array.swift
//  money
//
//  Created by Robert Dougan on 19/09/15.
//  Copyright © 2015 Phyn3t. All rights reserved.
//

import Foundation

extension NSIndexSet {
    
    func toArray() -> [Int] {
        var indexes:[Int] = [];
        self.enumerateIndexesUsingBlock { (index:Int, _) in
            indexes.append(index);
        }
        return indexes;
    }
    
}