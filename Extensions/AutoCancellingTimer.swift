//
// Source: https://gist.github.com/evgenyneu/516f7dcdb5f2f73d7923
//
// A timer that runs code after delay.
// The timer lives in an instance of `AutoCancellingTimer` class.
// It is automatically canceled when this instance is deallocated.
//
// Note: the word `cancelled` is spelled with two lls because I am from Australia :).
//
// Usage
// -----
//
//     class MyClass {
//         var timer: AutoCancellingTimer? // Timer will be cancelled with MyCall is deallocated
//
//         func runTimer() {
//             timer = AutoCancellingTimer(interval: delaySeconds, repeats: true) {
//                ... code to run
//             }
//         }
//     }
//
//
//  Cancel the timer
//  --------------------
//
//  Timer is canceled automatically when it is deallocated. You can also cancel it manually:
//
//     timer.cancel()
//

import Cocoa

final class AutoCancellingTimer {
    private var timer: AutoCancellingTimerInstance?
    
    init(interval: NSTimeInterval, repeats: Bool = false, callback: ()->()) {
        timer = AutoCancellingTimerInstance(interval: interval, repeats: repeats, callback: callback)
    }
    
    deinit {
        timer?.cancel()
    }
    
    func cancel() {
        timer?.cancel()
    }
}

final class AutoCancellingTimerInstance: NSObject {
    private let repeats: Bool
    private var timer: NSTimer?
    private var callback: ()->()
    
    init(interval: NSTimeInterval, repeats: Bool = false, callback: ()->()) {
        self.repeats = repeats
        self.callback = callback
        
        super.init()
        
        let newTimer = NSTimer(timeInterval: interval, target: self,
            selector: "timerFired:", userInfo: nil, repeats: repeats)
        
        timer = newTimer
        
        // Run timer in 'NSRunLoopCommonModes' to make it fire during scrolling
        NSRunLoop.mainRunLoop().addTimer(newTimer, forMode: NSRunLoopCommonModes)
    }
    
    func cancel() {
        timer?.invalidate()
    }
    
    func timerFired(timer: NSTimer) {
        self.callback()
        if !repeats { cancel() }
    }
}