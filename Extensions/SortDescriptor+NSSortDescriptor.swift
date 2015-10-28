//
//  SortDescriptor+NSSortDescriptor.swift
//  money
//
//  Created by Robert Dougan on 22/09/15.
//  Copyright © 2015 Phyn3t. All rights reserved.
//

import Foundation

import RealmSwift

extension SortDescriptor {
    
    static func withSortDescriptors(sortDescriptors: [NSSortDescriptor]) -> [SortDescriptor] {
        var descriptors = [SortDescriptor]()
        
        for sortDescriptor in sortDescriptors {
            descriptors.append(SortDescriptor(property: sortDescriptor.key!, ascending: sortDescriptor.ascending))
        }
        
        return descriptors
    }
    
}
