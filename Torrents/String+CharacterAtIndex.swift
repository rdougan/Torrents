//
//  String+CharacterAtIndex.swift
//  money
//
//  Created by Robert Dougan on 18/09/15.
//  Copyright © 2015 Phyn3t. All rights reserved.
//

import Foundation

extension String {
    
    subscript(integerIndex: Int) -> Character {
        let index = startIndex.advancedBy(integerIndex)
        return self[index]
    }
    
    subscript(integerRange: Range<Int>) -> String {
        let start = startIndex.advancedBy(integerRange.startIndex)
        let end = startIndex.advancedBy(integerRange.endIndex)
        let range = start..<end
        return self[range]
    }
    
}