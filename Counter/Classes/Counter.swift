//
//  Counter.swift
//  Pods
//
//  Created by Juanpe Catalán on 19/09/2017.
//
//

import Foundation

/// A type that has a `deltaValue`.
public protocol Countable {
    /// This value will be used to increment
    /// the counter
    var deltaValue: Int { get }
}

extension Int: Countable {
    public var deltaValue: Int {
        return self
    }
}

/// A type that has a `deltaValue`.
public protocol CounterDelegate{
    func counter(_ counter: Counter, willReachValue value: Int)
    func counter(_ counter: Counter, hasReachedValue value: Int)
    func counter(_ counter: Counter, didChangeValue value: Int)
}

extension CounterDelegate{
    func counter(_ counter: Counter, willReachValue value: Int) { }
    func counter(_ counter: Counter, hasReachedValue value: Int) { }
    func counter(_ counter: Counter, didChangeValue value: Int) { }
}

public class Counter{

    fileprivate var initialValue: Int = 0
    fileprivate var milestones = Set<Int>()
    fileprivate var handledMilestones = Set<Int>()
    internal var value: Int = 0 {
        willSet {
            notifyDelegateWill(oldValue: value, newValue: newValue)
        }
        didSet {
            notifyDelegate()
        }
    }
    
    public var delegate: CounterDelegate?
    
    public init(startIn start: Int = 0) {
        self.initialValue = start
        self.value = start
    }
    
    public func add(milestone: Int) {
        guard !milestones.contains(milestone) else { return }
        milestones.insert(milestone)
    }
    
    public func remove(milestone: Int) {
        guard milestones.contains(milestone) else { return }
        milestones.remove(milestone)
    }
    
    public func reset() {
        value = initialValue
        handledMilestones.removeAll()
    }
    
    public var currentValue: Int{
        return value
    }
    
    public static func sum(countables: Countable...) -> Int {
        let tempCounter = Counter()
        tempCounter.sum(countables: countables)
        return tempCounter.currentValue
    }
    
    public func sum(countables: Countable...) {
        sum(countables: countables)
    }
    
    private func sum(countables: [Countable]) {
        countables.forEach {
            self.value += $0.deltaValue
        }
    }
    
    public func increment(_ value: Countable = 1) {
        self.value += abs(value.deltaValue)
    }
    
    public func decrement(_ value: Countable = 1) {
        self.value -= abs(value.deltaValue)
    }
    
    fileprivate func notifyDelegateWill(oldValue: Int, newValue: Int) {
        guard let delegate = delegate else { return }
        milestones.forEach{ milestone in
            guard !self.handledMilestones.contains(milestone), newValue >= milestone else { return }
            delegate.counter(self, willReachValue: milestone)
        }
    }
    
    fileprivate func notifyDelegate() {
        guard let delegate = delegate else { return }
        delegate.counter(self, didChangeValue: value)
        milestones.forEach{ milestone in
            guard !self.handledMilestones.contains(milestone), value >= milestone else { return }
            delegate.counter(self, hasReachedValue: milestone)
            self.handledMilestones.insert(milestone)
        }
        
    }
}

