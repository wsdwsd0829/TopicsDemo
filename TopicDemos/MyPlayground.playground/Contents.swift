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

//MARK: Command Pattern
protocol Command {  //obj method params
    func execute()
    var obj: AnyClass { get set }
    var block: (Int) -> Void { get set }
    var param: Int { get set }
}
class CalculatorCommand: Command {
    func execute() {
        obj.perform { 
            block(self.param)
        }
    }
    var obj: AnyClass
    var block: ((Int)->Void)
    var param: Int
    
    init(obj: AnyClass, block: (Int) -> Void, param: Int) {
        self.obj = obj
        self.block = block
        self.param = param
    }
}
protocol Commands {
    var commands: [Command] { get set }
    func register(obj: AnyClass, block: (Int)->Void, param: Int)
}
class Calculator: Commands {
    var commands = [Command]()
    func register(obj: AnyClass, block: (Int) -> Void, param: Int) {
        
    }
    private(set) var total = 0;
    func add(amount:Int) {
        total += amount;
        
       commands.append(CalculatorCommand(self, substract, amount))
    }
    func subtract(amount:Int) {
        total -= amount;
        
        commands.append(CalculatorCommand(self, add, amount))
    }
    func multiply(amount:Int) {
        var tempTotal = total
        total = total * amount;
        
        if amount != 0 {
        commands.append(CalculatorCommand(self, divide, amount))
        } else {
         commands.append(CalculatorCommand(self, setTotal, tempTotal))
        }
    }
    
    func divide(amount:Int) {
        guard amount != 0 else {
            fatalError("cannot divide by 0")
        }
        total = total / amount;
        commands.append(CalculatorCommand(self, multiply, amount))
    }
    
    private func setTotal(amount: Int) {
        total = amount
    }
}

let calc = Calculator()

func testRun() {
    calc.add(amount: 3)
    calc.total
    calc.multiply(amount: 5)
    calc.total
    calc.multiply(amount: 3)
    calc.total
    calc.divide(amount: 9)
    calc.total
    calc.subtract(amount: 2)
    calc.total
}
func testUndo() {
    while calc.commands.count > 0 {
        calc.commands.removeLast().execute()
        calc.commands.removeLast()
    }
}
testRun()
//print("--------------")
//testUndo()














