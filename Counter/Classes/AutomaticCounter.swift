//
//  AutomaticCounter.swift
//  Counter
//
//  Created by Juan Navas Martin on 12/10/17.
//

import Foundation

public protocol AutomaticCounterDelegate: CounterDelegate {
    func counter(_ counter: Counter, didFinishCounting value: Int)
}

extension AutomaticCounterDelegate {
    func counter(_ counter: Counter, didFinishCounting value: Int) {}
}

public class AutomaticCounter: Counter {
    
    public var automaticDelegate: AutomaticCounterDelegate?
    
    var endValue: Int?
    var interval: TimeInterval
    var autoIncrement: Countable
    var timer: Timer?
    
    public init(startIn start: Int, interval: TimeInterval = 1.0, autoIncrement: Countable = 1) {
        self.interval = interval
        self.autoIncrement = autoIncrement
        super.init(startIn: start)
    }
    
    public func startCounting(endingAt end: Int? = nil) {
        if timer != nil {
            endCounting()
            reset()
        }
        self.endValue = end
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(increment), userInfo: nil, repeats: true)
        timer?.fire()
    }
    
    public func endCounting() {
        timer?.invalidate()
        timer = nil
        automaticDelegate?.counter(self, didFinishCounting: value)
    }
    
    @objc private func increment() {
        if let endValue = endValue, value >= endValue {
            endCounting()
            return
        }
        increment(autoIncrement)
    }
}
