//
//  NSApplication+Window.swift
//  money
//
//  Created by Robert Dougan on 14/10/15.
//  Copyright © 2015 Phyn3t. All rights reserved.
//

import Cocoa

extension NSApplication {
    
    class var window: NSWindow {
        return NSApplication.sharedApplication().windows.first!
    }
    
}
