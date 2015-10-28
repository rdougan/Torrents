//
//  NSDate+Formatted.swift
//  money
//
//  Created by Robert Dougan on 18/09/15.
//  Copyright © 2015 Phyn3t. All rights reserved.
//

import Foundation

extension NSDate {
    
    func formattedStringWithStyle(dateStyle: NSDateFormatterStyle, timeStyle: NSDateFormatterStyle) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = dateStyle
        dateFormatter.timeStyle = timeStyle
        
        return dateFormatter.stringFromDate(self)
    }
    
    func formattedStringWithStyle(dateFormat: String) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = dateFormat
        
        return dateFormatter.stringFromDate(self)
    }
    
    class func dateWithString(string: String, dateFormat: String) -> NSDate? {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = NSTimeZone(name: "GMT")
        
        return dateFormatter.dateFromString(string)
    }
    
}
