//
//  CommandPattern.swift
//  TopicDemos
//
//  Created by Sida Wang on 3/18/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

import Foundation

//Summary: Receiver object, execute; GenericCommand

//TODO improve as Book
protocol Command {  //obj method params
    func execute()
}

//MARK: My version of Command
class CalculatorCommand: Command {
    func execute() {
        //(obj as! Calculator).per
        block(param) //block can preserve the obj's context when saved, this will make obj not necessary //how? disadvantage?
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
//MAKR: book's 
class GenericCommand<T>: Command {

    private var receiver: T
    private var instruction: (T)->Void
    
    init(receiver: T, instruction: @escaping (T)->Void) {
        self.receiver = receiver
        self.instruction = instruction
    }
    
    func execute() {
        instruction(receiver)
    }
}

protocol Commands {
    var commands: [Command] { get set }
}

class Calculator: NSObject, Commands {
    var commands = [Command]()

    private(set) var total = 0;
    func add(amount:Int) {
        total += amount;
        //IMPORTANT: substract of type: (Int)->Void,
        //IMPORTANT: Calculator.substract of type: (Calculator)-> ((Int)->Void)
        //commands.append(CalculatorCommand(obj: self, block: substract, param: amount))
        
        //this not good: should think about interface instead of impl
        
        commands.append(GenericCommand<Calculator>(receiver: self, instruction: { calc in
            Calculator.substract(calc)(amount: amount)
            })
        )
        
        //good version: think about interface instead of impl
        //self.addCommand(method: Calculator.substract, amount: amount)

    }
    
    func substract(amount:Int) {
        total -= amount;
        
        self.addCommand(method: Calculator.add, amount: amount)
        //commands.append(CalculatorCommand(obj: self, block: add, param: amount))
    }
    
    func multiply(amount:Int) {
        let tempTotal = total
        total = total * amount;
        
        if amount != 0 {
            commands.append(CalculatorCommand(obj: self, block: divide, param: amount))
        } else {
            commands.append(CalculatorCommand(obj: self, block: setTotal, param: tempTotal))
        }
        //self.addCommand(method: Calculator.divide, amount: amount)

    }
    
    func divide(amount:Int) {
        guard amount != 0 else {
            fatalError("cannot divide by 0")
        }
        total = total / amount;
        
        commands.append(CalculatorCommand(obj: self, block: multiply, param: amount))
        
        //self.addCommand(method: Calculator.multiply, amount: amount)

    }
    
    private func setTotal(amount: Int) {
        total = amount
    }
    
    private func addCommand(method: @escaping (Calculator)-> ((Int)->Void), amount: Int) {
        let cmd = GenericCommand<Calculator>(receiver: self, instruction: { calc in
            method(calc)(amount)
        })
        commands.append(cmd)
    }
}















