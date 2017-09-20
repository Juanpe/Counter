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

class ViewController: UIViewController, CounterDelegate {

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
}

