//
//  AutomaticCounter.swift
//  Counter
//
//  Created by Juan Navas Martin on 12/10/17.
//

import Foundation

public protocol AutomaticCounterDelegate: CounterDelegate {
    func counter(_ counter: AutomaticCounter, didFinishCounting value: Int)
}

extension AutomaticCounterDelegate {
    func counter(_ counter: AutomaticCounter, didFinishCounting value: Int) {}
}

public class AutomaticCounter {
    
    public weak var delegate: AutomaticCounterDelegate? {
        didSet { self.counter.delegate = self.delegate }
    }
    
    var endValue: Int?
    var endTime: TimeInterval?
    var interval: TimeInterval
    var autoIncrement: Countable
    var timer: Timer?
    var timeValue: TimeInterval
    
    private let counter: Counter
    
    public init(startIn start: Int, interval: TimeInterval = 1.0, autoIncrement: Countable = 1) {
        self.interval = interval
        self.autoIncrement = autoIncrement
        self.timeValue = 0
        self.counter = Counter(startIn: start)
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
    public func startCounting(endingAfter end: TimeInterval?) {
        self.endTime = end
        startCounting()
    }
    
    public func endCounting() {
        timer?.invalidate()
        timer = nil
        delegate?.counter(self, didFinishCounting: counter.value)
    }
    public func reset() {
        counter.reset()
        timeValue = 0
    }
    
    public func add(milestone: Int) {
        counter.add(milestone: milestone)
    }
    
    public func remove(milestone: Int) {
        counter.remove(milestone: milestone)
    }
    
    @objc private func increment() {
        if let endValue = endValue, counter.value >= endValue {
            endCounting()
            return
        }
        if let endTime = endTime, timeValue >= endTime {
            endCounting()
            return
        }
        counter.increment(autoIncrement)
        timeValue += interval
    }
}
