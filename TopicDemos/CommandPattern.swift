//
//  CommandPattern.swift
//  TopicDemos
//
//  Created by Sida Wang on 3/18/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

import Foundation
protocol Command {  //obj method params
    func execute()
    var obj: AnyObject { get set }
    var block: (Int) -> Void { get set }
    var param: Int { get set }
}
class CalculatorCommand: Command {
    func execute() {
        //(obj as! Calculator).per
        block(param)
    }
    var obj: AnyObject
    var block: ((Int)->Void)
    var param: Int
    
    init(obj: AnyObject,  block: @escaping (Int) -> Void, param: Int) {
        self.obj = obj
        self.block = block
        self.param = param
    }
}
protocol Commands {
    var commands: [Command] { get set }
    func register(obj: AnyObject, block: (Int)->Void, param: Int)
}

class Calculator: NSObject, Commands {
    func register(obj: AnyObject, block: (Int) -> Void, param: Int) {
        
    }

    var commands = [Command]()

    private(set) var total = 0;
    func add(amount:Int) {
        total += amount;
        
        commands.append(CalculatorCommand(obj: self, block: substract, param: amount))
    }
    func substract(amount:Int) {
        total -= amount;
        
        commands.append(CalculatorCommand(obj: self, block: add, param: amount))
    }
    func multiply(amount:Int) {
        var tempTotal = total
        total = total * amount;
        
        if amount != 0 {
            commands.append(CalculatorCommand(obj: self, block: divide, param: amount))
        } else {
            commands.append(CalculatorCommand(obj: self, block: setTotal, param: tempTotal))
        }
    }
    
    func divide(amount:Int) {
        guard amount != 0 else {
            fatalError("cannot divide by 0")
        }
        total = total / amount;
        commands.append(CalculatorCommand(obj: self, block: multiply, param: amount))
    }
    
    private func setTotal(amount: Int) {
        total = amount
    }
}

