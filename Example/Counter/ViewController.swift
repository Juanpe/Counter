//
//  ViewController.swift
//  Counter
//
//  Created by Juanpe Catalán on 09/19/2017.
//  Copyright (c) 2017 Juanpe Catalán. All rights reserved.
//

import UIKit
import Counter

struct Person {
    var age: Int
}

extension Person: Countable{
    var deltaValue: Int {
        return self.age
    }
}

class ViewController: UIViewController, CounterDelegate, AutomaticCounterDelegate {
    
    var automaticCounter: AutomaticCounter!
    var automaticCounter2: AutomaticCounter!
    var automaticCounter3: AutomaticCounter!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let counter = Counter()
        counter.delegate = self
        counter.add(milestone: 3)
        print(counter.currentValue) // 0
        
        counter.increment()
        print(counter.currentValue) // 1
        
        counter.increment(2)
        print(counter.currentValue) // 3
        
        counter.decrement()
        print(counter.currentValue) // 2
        
        counter.reset()
        print(counter.currentValue) // 0
        
        counter.sum(countables: 2, 3, -1)
        print(counter.currentValue) // 4
        
        /// Advanced
        
        let dad = Person(age: 45)
        let mum = Person(age: 40)
        let son = Person(age: 25)
        
        let ageCounter = Counter()
        ageCounter.increment(dad)
        ageCounter.increment(mum)
        ageCounter.increment(son)
        
        print(ageCounter.currentValue) // 110
        
        ageCounter.reset()
        ageCounter.sum(countables: dad, mum, son)
        print(ageCounter.currentValue) // 110
        
        let ages = Counter.sum(countables: dad, mum, son)
        print(ages) // 110
        
        print("\n\n\nAUTOMATIC COUNTER\n\n\n")
        automaticCounter = AutomaticCounter(startIn: 0, interval: 0.5, autoIncrement: 1)
        automaticCounter.delegate = self
        automaticCounter.startCounting(endingAt: 10)
    }
    
    func launchTimer2() {
        automaticCounter2 = AutomaticCounter(startIn: 0, interval: 0.2)
        automaticCounter2.delegate = self
        automaticCounter2.startCounting()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.automaticCounter2.endCounting()
        }
    }
    
    func launchTimer3() {
        automaticCounter3 = AutomaticCounter(startIn: 0, interval: 1)
        automaticCounter3.delegate = self
        automaticCounter3.startCounting(endingAfter: 3)
    }
    
    func counter(_ counter: Counter, hasReachedValue value: Int) {
        print("\(#function) => \(value)")
    }
    
    func counter(_ counter: Counter, didChangeValue value: Int) {
        print("\(#function) => \(value)")
    }
    
    func counter(_ counter: Counter, willReachValue value: Int) {
        print("\(#function) => \(value)")
    }
    
    func counter(_ counter: AutomaticCounter, didFinishCounting value: Int) {
        print("\(#function) => \(value)\n\n")
        if automaticCounter === counter {
            launchTimer2()
        }
        else if automaticCounter2 === counter {
            launchTimer3()
        }
    }
}

