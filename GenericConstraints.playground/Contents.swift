//: Playground - noun: a place where people can play

import UIKit

/*
 Summary: 
 1. overloading function must cover all cases;
 2. general one will called if no constraint's method matches;
 3. Two kind of examples:  <T:P> or where T: Equatable
 */

protocol P {}
class Foo: P {}
class Bar: P {}
class Empty: P {}
func doTemplatedNothing<T: P>(forItem item: T) where T: Foo {
    debugPrint("doing foo")
}

func doTemplatedNothing<T>(forItem item: T) where T: Bar {
    debugPrint("doing bar")
}

func doTemplatedNothing<T>(forItem item: T) { // where T: P -> cannot invoke 'doTemplatedNothing' with an argument list of type '(forItem: P)'
    debugPrint("doing nothing")
}

//MARK: Fix 1 A less Elegant fix to replace Do things
//func doTheThings<P1, P2 where P1: Foo, P2: Bar> (p1: P1, p2: P2) {
//    doTemplatedNothing(forItem: p1)    // "doing nothing"
//    doTemplatedNothing(forItem: p2)    // "doing nothing"
//}

//WHY!!!, not printing doing foo, doing bar
func doTheThings(p1: P, p2: P) {
    doTemplatedNothing(forItem: p1)    // "doing nothing"
    doTemplatedNothing(forItem: p2)    // "doing nothing"
}

func doTheTypedThings(p1: Foo, p2: Bar) {
    doTemplatedNothing(forItem: p1)   // "doing foo"
    doTemplatedNothing(forItem: p2)   // "doing bar"
}

let fooInstance = Foo()
let barInstance = Bar()

let emptyInstance = Empty()
//MARK: Fix 2 prove func casting to protocol will loose original identity
doTemplatedNothing(forItem: fooInstance)   // "doing foo"
doTemplatedNothing(forItem: barInstance)   // "doing bar"
doTemplatedNothing(forItem: emptyInstance)

print("--------------------")
doTheThings(p1: fooInstance, p2: barInstance)
print("--------------------")
doTheTypedThings(p1: fooInstance, p2: barInstance)


class DBStore<T>
{
    func store<T>(a : T) where T: Foo {
    }
    func store<T>(a : T) where T: Bar {
    }
    func store<T>(a : T) where T: P {
    }

}


