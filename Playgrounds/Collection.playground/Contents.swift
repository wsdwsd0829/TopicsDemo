//: Playground - noun: a place where people can play
import UIKit

//Task: create a sequence of Fibonacci;
//MARK: Iterator
struct FibIterator: IteratorProtocol {
    var state = (0, 1)
    typealias Element = Int
    mutating func next() -> Int? {
        let res = state.0
        state = (state.1, state.0 + state.1)
        return res
    }
}

var fibIter = FibIterator()
for i in 0..<10 {
    print(fibIter.next() ?? -1)
}
//MARK: Sequence
struct FibSequence: Sequence {
    func makeIterator() -> FibIterator {
        return FibIterator()
    }
}
for i in FibSequence().prefix(10) {
    print("sequece \(i)")
}
//MARK: Example2 Sequence and IteratorProtocol use together
struct Countdown: Sequence, IteratorProtocol {
    var count: Int
    
    mutating func next() -> Int? {
        if count == 0 {
            return nil
        } else {
            defer { count -= 1 }
            return count
        }
    }
}
let threeToGo = Countdown(count: 3)
for i in threeToGo {
    print(i)
}
for i in threeToGo {
    print(i)
}
print("--------")
class Countdown2: Sequence, IteratorProtocol {
    var count: Int
    init(count: Int) {
        self.count = count
    }
    func next() -> Int? {
        if count == 0 {
            return nil
        } else {
            defer { count -= 1 }
            return count
        }
    }
}
let threeToGo2 = Countdown2(count: 3)
for i in threeToGo2 {  //threeToGo is copied; struct is copy by value, save to use repeatly, class is not.
    print(i)
}
for i in threeToGo2 {
    print("hi")
    print(i)
}
print(threeToGo2.count)

