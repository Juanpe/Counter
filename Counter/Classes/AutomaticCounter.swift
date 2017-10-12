//
//  AutomaticCounter.swift
//  Counter
//
//  Created by Juan Navas Martin on 12/10/17.
//

import Foundation

public class AutomaticCounter: Counter {
    
    var endValue: Int?
    var interval: TimeInterval
    var autoIncrement: Countable
    
    private var timer: Timer?
    
    public init(startIn start: Int, interval: TimeInterval = 1.0, autoIncrement: Countable = 1) {
        self.interval = interval
        self.autoIncrement = autoIncrement
        super.init(startIn: start)
    }
    
    public func startCounting(endingAt end: Int? = nil) {
        self.endValue = end
        if #available(iOS 10.0, *) {
            timer = Timer(timeInterval: interval, repeats: true, block: { [weak self] _ in self?.increment() })
        }
        else {
            timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(increment), userInfo: nil, repeats: true)
        }
        timer?.fire()
    }
    
    public func endCounting() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func increment() {
        if let endValue = endValue, value >= endValue {
            endCounting()
        }
        increment(autoIncrement)
    }
    
}
