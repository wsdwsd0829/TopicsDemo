//: Playground - noun: a place where people can play

import UIKit

protocol P {}
class Foo: P {}
class Bar: P {}

func doTemplatedNothing<T>(forItem item: T) where T: Foo {
    debugPrint("doing foo")
}

func doTemplatedNothing<T>(forItem item: T) where T: Bar {
    debugPrint("doing bar")
}

func doTemplatedNothing<T>(forItem item: T) { // where T: P
    debugPrint("doing nothing")
}

//func doTemplatedNothing<T>(forItem item: T) where T: P {
//    debugPrint("doing nothing")
//}

//A less Elegant fix to replace Do things
func doTheThings<P1, P2> (p1: P1, p2: P2) where P1: Foo, P2: Bar {
    doTemplatedNothing(forItem: p1)    // "doing nothing"
    doTemplatedNothing(forItem: p2)    // "doing nothing"
}

//WHY!!!, not printing doing foo, doing bar
//func doTheThings(p1: P, p2: P) {
//    doTemplatedNothing(forItem: p1)    // "doing nothing"
//    doTemplatedNothing(forItem: p2)    // "doing nothing"
//}

func doTheTypedThings(p1: Foo, p2: Bar) {
    doTemplatedNothing(forItem: p1)   // "doing foo"
    doTemplatedNothing(forItem: p2)   // "doing bar"
}

let fooInstance = Foo()
let barInstance = Bar()

doTheThings(p1: fooInstance, p2: barInstance)
doTheTypedThings(p1: fooInstance, p2: barInstance)


