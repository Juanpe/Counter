![](http://cdn.juanpecatalan.com/images/github/Counter/counter_header_v1.jpg)

<p align="center">
<a href="http://cocoapods.org/pods/Counter">
  <img src="https://img.shields.io/cocoapods/v/Counter.svg?style=flat" alt="Version" />
</a>
<a href="http://cocoapods.org/pods/Counter">
  <img src="https://img.shields.io/cocoapods/p/Counter.svg?style=flat" alt="Platform" />
</a>
<a href="https://twitter.com/juanpeCMiOS">
        <img src="https://img.shields.io/badge/contact-@juanpeCMiOS-blue.svg?style=flat" alt="Twitter: @juanpeCMiOS" />
    </a>
<a href="https://opensource.org/licenses/MIT">
  <img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="License" />
</a>
</p>

**Counter**  is powerful and multipurpose counter.

## Features 🚀

- [x] Easy to use
- [x] Increment/Decrement
- [x] Sum various values
- [x] Use your own objects

### Supported OS & SDK Versions 📋

* iOS 9.0+
* Swift 3

## Installation 📲

#### Using [CocoaPods](https://cocoapods.org)

Edit your `Podfile` and specify the dependency:

```ruby
pod "Counter"
```

#### Using [Carthage](https://github.com/Carthage/Carthage)

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate Counter into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "Juanpe/counter"
```

Run `carthage` to build the framework and drag the built `counter.framework` into your Xcode project.

#### Manually 💪🏼

  If you prefer, you can integrate Counter into your project manually. Simply add the `Counter.swift` source file directly into your project.

## How to use 🐒

Import Counter in proper place.
```swift
import Counter
```
Now, you only need to create a Counter instance and start to play 🙂

```swift
let counter = Counter() // 0
counter.increment()     // 1
```

You can specify how many units you want increment the counter

```swift
counter.increment(2)    // 3
```

Also you can decrement the count

```swift
counter.decrement()     // 2
```

And of course you can reset the counter

```swift
counter.reset()         // 0
```

Other powerful feature is that you can sum various values at the same time

```swift
counter.sum(countables: 2, 3, -1)  // 4
```

#### Advanced 🤓

Can use your own objects to increment the counter. Only need implement `Countable` protocol:

```swift
protocol Countable {
    var deltaValue: Int { get }
}
```

For example:

```swift
struct Person {
    var age: Int
}

extension Person: Countable{
    var deltaValue: Int {
        return self.age
    }
}

let dad = Person(age: 45)
let mum = Person(age: 40)
let son = Person(age: 25)

let ageCounter = Counter()
ageCounter.increment(dad)
ageCounter.increment(mum)
ageCounter.increment(son)

print(ageCounter.currentValue) // 110

// Also you can use `sum` method or static method

ageCounter.sum(dad, mum, son) // 110

let ages = Counter.sum(dad, mum, son) // 110


```

#### Callbacks 🔁

You can create `milestones`

## Contributed ❤️
This is an open source project, so feel free to contribute. How?
- Open an [issue](https://github.com/Juanpe/Counter/issues/new).
- Send feedback via [email](mailto://juanpecatalan.com).
- Propose your own fixes, suggestions and open a pull request with the changes.

## Author 👨🏻‍💻

  * Juanpe Catalán [🐦](https://www.twitter.com/juanpecmios)

## License 👮🏻

```
MIT License

Copyright (c) 2017 swift-code

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
