//
//  String+Regex.swift
//  money
//
//  Created by Robert Dougan on 18/09/15.
//  Copyright © 2015 Phyn3t. All rights reserved.
//

import Foundation

extension String {
    
    var length: Int {return self.characters.count - 1} // Assuming ZERO indexed
    var count: Int {return self.characters.count} // Assuming ONE indexed
    
    func rightMostMatchForRegex(regex r: String) -> String? {
        /* Find the right most match for given reguar expression
        */
        
        let regex = try? NSRegularExpression(pattern: r, options: [])
        if regex == nil {
            print("Invalid regex: \(r)")
            return self
        }
        for (var i = self.length; i >= 0; i--) {
            let matches = regex!.matchesInString(self, options: [], range: NSMakeRange(i, self.count - i))
            if matches.count > 0 {
                let range = matches[0].rangeAtIndex(0)
                return (self as NSString).substringWithRange(range)
            }
        }
        return nil
    }
    
    func replaceRightMostMatchForRegex(regex r: String, withString string: String) -> String {
        /* Replace the right most match to the provided regular expression
        */


        let regex = try? NSRegularExpression(pattern: r, options: [])
        if regex == nil {
            print("invalid regex: \(r)")
            return self
        }


        for (var i = self.length; i >= 0; i--) {
            let match = regex!.matchesInString(self, options: [], range: NSMakeRange(i, self.count - i))
            if match.count > 0 {
                return regex!.stringByReplacingMatchesInString(self, options: [], range: NSMakeRange(i, self.count - i), withTemplate: string)
            }
        }
        return self
    }
    
    func matchesForRegex(regex: String) -> [String]? {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [])
            let nsString = self as NSString
            let matches = regex.matchesInString(self, options: [], range: NSMakeRange(0, nsString.length))
            
            var results = [String]()
            
            for match in matches {
                let numberOfRanges = match.numberOfRanges
                
                for (var i = 0; i < numberOfRanges; i++) {
                    let range = match.rangeAtIndex(i)
                    results.append(nsString.substringWithRange(range))
                }
            }
            
            if (results.count == 0) {
                return nil
            }
            
            return results
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            return nil
        }
    }
    
    func stringByReplacingOccurrencesOfRegex(regex: String, withString string: String) -> String {
        do {
            let nsString = self as NSString
            let regex = try NSRegularExpression(pattern: regex, options: [])
            
            return regex.stringByReplacingMatchesInString(self, options: [], range: NSMakeRange(0, nsString.length), withTemplate: string)
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            return self
        }
    }
    
    func matches(regex: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [])
            let nsString = self as NSString
            let matches = regex.matchesInString(self, options: [], range: NSMakeRange(0, nsString.length))
            
            return matches.count > 0
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            return false
        }
    }
    
}
