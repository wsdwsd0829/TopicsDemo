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


struct ReverseIterator: IteratorProtocol {
    var index: Int
    init<T>(array: [T]) {
        self.index = array.endIndex - 1
    }
    mutating func next() -> Int? {
        defer {
            index -= 1
        }
        guard index >= 0 else { return nil }
       return index
    }
}

print("-----------")

var arr = [1,2,3,4,5]
var reverseIterator = ReverseIterator(array: arr)
while let index = reverseIterator.next() {
    print(arr[index])
}
struct ReverseIndices<T>: Sequence {
    let array: [T]
    init(array: [T]) {
        self.array = array
    }
    
    func makeIterator() -> ReverseIterator {
        return ReverseIterator(array: array)
    }
    
    //same as map
    func mymap<T>(_ transform: (Int) throws -> T) rethrows -> [T] {
        var iter = makeIterator()
        var result = [T]()
        while let index = iter.next(), let elem = try? transform(index) {
            result.append(elem)
        }
        return result
    }
}

var arr1 = ["one", "two", "three"]
var reverseSequence = ReverseIndices(array: arr1)
let elemSequence = reverseSequence.mymap {
    arr1[$0]
}

for elem in elemSequence {
    print(elem)
}

let res = (1...10).lazy.filter{ $0 % 3 == 0 }.map { $0 * $0 }
print(res)
for i in res {
    print(i)
}




