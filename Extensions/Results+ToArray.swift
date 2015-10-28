//
//  Results+ToArray.swift
//  money
//
//  Created by Robert Dougan on 21/09/15.
//  Copyright © 2015 Phyn3t. All rights reserved.
//

import Foundation

import RealmSwift

extension Results {
    
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for result in self {
            if let result = result as? T {
                array.append(result)
            }
        }
        return array
    }
    
}