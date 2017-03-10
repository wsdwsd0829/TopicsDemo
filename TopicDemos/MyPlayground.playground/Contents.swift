//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let ratio = 1/5
let n: Double = 1
let m: Double = 2
let ration2 = n/m

enum ErrorCode: Int {
    case Network = 101, Database = 102
    case Unknown = 0
}

let errors: [ErrorCode] = [.Network, .Database]
errors.contains(.Network)
errors.contains(.Unknown)
