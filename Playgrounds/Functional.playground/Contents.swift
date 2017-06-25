//: Playground - noun: a place where people can play

import UIKit
//Curry

func curryMultiply(val1: Int) -> (String) -> (Int) -> Int {
    return { str in
        return { val2 in
            if str == "*" {
                return val1*val2
            }
            return -1
        }
    }
}

curryMultiply(val1: 2)("*")(3)

for i in "string" {
    print(i)
}
