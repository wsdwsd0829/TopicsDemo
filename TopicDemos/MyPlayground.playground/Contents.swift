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


//Summary:

enum Terrain: String {
    case forest = "F"
    case mountain = "M"
    case water = "W"
}

MemoryLayout.size(ofValue: Terrain.forest) // → 1 (byte)
MemoryLayout.size(ofValue: "F") // → 24 (bytes)

class Manager  {
    static var managers = [String: Manager]()
    static func createManager(with name: String) -> Manager {
        let aManager = Manager()
        Manager.managers[name] = aManager
        Manager.managers
        return aManager
    }
}

func createManagerAndDisgard() {
    Manager.createManager(with: "hello")
}

func createManagerAndDisgard2() {
    Manager.createManager(with: "hello2")
}
createManagerAndDisgard()
createManagerAndDisgard2()
Manager.managers





















