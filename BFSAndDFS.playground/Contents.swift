//: Playground - noun: a place where people can play


import UIKit

func address(of person: Person) {
    //cannot pass in as parameter
    var p = person
    withUnsafePointer(to: &p) {
        print($0.pointee)

    }
}
protocol Search {
    func maxGenerations() -> Int
    func mostRecentAncestor(named: String) -> Person?
}
class Person: NSObject, Search {
    var name: String
    var left: Person?
    var right: Person?
    init(name: String, left: Person? = nil, right: Person? = nil) {
        self.name = name
        self.left = left
        self.right = right
    }
    func maxGenerations() -> Int {
        if left == nil && right == nil {
            return 0
        }
        if left == nil || right == nil {
            return (left == nil ? right!.maxGenerations() : left!.maxGenerations()) + 1
        }
        let leftG = left?.maxGenerations() ?? 0
        let rightG = right?.maxGenerations() ?? 0
        return max(leftG, rightG) + 1
    }
    func mostRecentAncestor(named: String) -> Person? {
        var candidate = [left, right].flatMap {$0}
        while candidate.count > 0 {
            let find = candidate.filter{ $0.name == named }
            if find.count > 0 {
                //print("abc")
                return find.first
            }
            //next level
            var temp = [Person]()
            candidate.forEach {
                if let left = $0.left {
                    temp.append(left)
                }
                if let right = $0.right {
                    temp.append(right)
                }
                //print("level \($0.name)")
            }
            candidate = temp
        }
        return nil
    }
    func p() {
        print("hello")
    }
}

var johnJunior = Person(name: "John")
var nancy = Person(name: "Nancy")
var robert = Person(name: "Robert")
var marie = Person(name: "Marie")
var ruth = Person(name: "Ruth")
var johnSenior = Person(name: "John")
var leila = Person(name: "Leila")
var herbert = Person(name: "Herbert")
var dianne = Person(name: "Dianne")
var doug = Person(name: "Doug")
var mark = Person(name: "Mark")

//Why???


//address(of: johnJunior)
//address(of: johnSenior)
//address(of: mark)

mark.left = dianne
mark.right = doug

dianne.left = ruth
dianne.right = johnSenior

doug.left = leila
doug.right = herbert

ruth.left = nancy

leila.left = marie

herbert.right = robert

robert.right = johnJunior

//TEST CASE
//mark.maxGenerations()

var found = mark.mostRecentAncestor(named: "John")!
found.name
found === johnSenior
found === johnJunior

var nJohn = johnSenior
var nJohn2 = johnSenior
var nJohn3 = johnSenior

withUnsafePointer(to: &johnSenior) {
    print($0)
    //$0 is temp //what printed out is addr of $0 that save addr of johnSenior
    //pointee is johnSenior and print's is address
    $0.pointee === johnSenior
    print($0.pointee)
    print(johnSenior)
}


































