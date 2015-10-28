//
//  NSBezierPath+UIKit.swift
//  money
//
//  Created by Robert Dougan on 07/10/15.
//  Copyright © 2015 Phyn3t. All rights reserved.
//

import Cocoa

struct NSRectCorner : OptionSetType {
    let rawValue: Int
    init(rawValue: Int) { self.rawValue = rawValue }
    
    static let TopLeft = NSRectCorner(rawValue: 1)
    static let TopRight = NSRectCorner(rawValue: 2)
    static let BottomLeft = NSRectCorner(rawValue: 4)
    static let BottomRight = NSRectCorner(rawValue: 8)
    static let AllCorners = [NSRectCorner.TopLeft, NSRectCorner.TopRight, NSRectCorner.BottomLeft, NSRectCorner.BottomRight]
}

extension NSBezierPath {
    
    convenience init(roundedRect: CGRect, byRoundingCorners: NSRectCorner, cornerRadii: CGFloat) {
        self.init()
        
        self.moveToPoint(NSMakePoint(NSMinX(roundedRect), NSMidY(roundedRect)))
        
        if (byRoundingCorners.contains(.TopLeft)) {
            self.appendBezierPathWithArcFromPoint(NSMakePoint(NSMinX(roundedRect), NSMaxY(roundedRect)), toPoint: NSMakePoint(NSMinX(roundedRect) + cornerRadii, NSMaxY(roundedRect)), radius: cornerRadii)
        }
        else {
            self.lineToPoint(NSMakePoint(NSMinX(roundedRect), NSMaxY(roundedRect)))
        }
        
        if (byRoundingCorners.contains(.TopRight)) {
            self.appendBezierPathWithArcFromPoint(NSMakePoint(NSMaxX(roundedRect), NSMaxY(roundedRect)), toPoint: NSMakePoint(NSMaxX(roundedRect), NSMaxY(roundedRect) - cornerRadii), radius: cornerRadii)
        }
        else {
            self.lineToPoint(NSMakePoint(NSMaxX(roundedRect), NSMaxY(roundedRect)))
        }
        
        if (byRoundingCorners.contains(.BottomRight)) {
            self.appendBezierPathWithArcFromPoint(NSMakePoint(NSMaxX(roundedRect), NSMinY(roundedRect)), toPoint: NSMakePoint(NSMaxX(roundedRect) - cornerRadii, NSMinY(roundedRect)), radius: cornerRadii)
        }
        else {
            self.lineToPoint(NSMakePoint(NSMaxX(roundedRect), NSMinY(roundedRect)))
        }

        if (byRoundingCorners.contains(.BottomLeft)) {
            self.appendBezierPathWithArcFromPoint(NSMakePoint(NSMinX(roundedRect), NSMinY(roundedRect)), toPoint: NSMakePoint(NSMinX(roundedRect), NSMinY(roundedRect) + cornerRadii), radius: cornerRadii)
        }
        else {
            self.lineToPoint(NSMakePoint(NSMinX(roundedRect), NSMinY(roundedRect)))
            self.lineToPoint(NSMakePoint(NSMinX(roundedRect), NSMidY(roundedRect)))
        }
    }
    
}
