//
//  Results+Group.swift
//  money
//
//  Created by Robert Dougan on 29/09/15.
//  Copyright © 2015 Phyn3t. All rights reserved.
//

import Foundation

import RealmSwift

public extension Results {
    
    func group<U: Hashable>(@noescape keyFunc: Generator.Element -> U) -> [U: [Generator.Element]] {
        var dict: [U: [Generator.Element]] = [:]
        
        for el in self {
            let key = keyFunc(el)
            dict[key]?.append(el) ?? {dict[key] = [el]}()
        }
        
        return dict
    }
    
}
