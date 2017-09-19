//
//  Counter.swift
//  Pods
//
//  Created by Juanpe Catalán on 19/09/2017.
//
//

import Foundation

public protocol Countable {
    var deltaValue: Int { get }
}

func + (lhs: Countable, rhs: Countable) -> Int{
    return lhs.deltaValue + rhs.deltaValue
}

extension Int: Countable {
    public var deltaValue: Int {
        return self
    }
}

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
    fileprivate var value: Int = 0 {
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
        if let delegate = delegate {
            milestones.forEach{ milestone in
                guard !self.handledMilestones.contains(milestone) else { return }
                if newValue >= milestone {
                    delegate.counter(self, willReachValue: milestone)
                }
            }
        }
    }
    
    fileprivate func notifyDelegate() {
        if let delegate = delegate {
            delegate.counter(self, didChangeValue: value)
            milestones.forEach{ milestone in
                guard !self.handledMilestones.contains(milestone) else { return }
                if value >= milestone {
                    delegate.counter(self, hasReachedValue: milestone)
                    self.handledMilestones.insert(milestone)
                }
            }
        }
    }
}

