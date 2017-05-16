//: Playground - noun: a place where people can play

import UIKit

 protocol Foo {
    var test: URL? { get }
}

class Klass: NSObject {
//MARK: computed property cannot be overload
//    var test: String? {
//        return "Test"
//    }
//    var test: URL? {
//        return URL(string: "fake")
//    }
//MARK: function can be overload in Swift not in objective c if first param is same  //remove NSObject to fix; or change "url:" to "a url:"
    func test(_ url: String) {
    }
    func test(a url: URL) {
    }
}

extension Klass {
//    var test: URL? {
//        return URL(string: "fake")
//    }
}

