//
//  SwiftCapture.swift
//  TopicDemos
//
//  Created by Sida Wang on 6/28/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

import UIKit

//http://alisoftware.github.io/swift/closures/2016/07/25/closure-capture-1/
/**
 sum
 By default capture -> EE: Evaluate at Execution time, 
                    -> and can change val in block to affect out side
 By capture list -> CC: Capture at Creation time
                 -> capture by Copy either value or ref (not affect outside)
 
 */

class SwiftCapture: NSObject {
    class Pokemon: CustomDebugStringConvertible {
        let name: String
        init(name: String) {
            self.name = name
        }
        var debugDescription: String { return "<Pokemon \(name)>" }
        deinit { print("\(self) escaped!") }
    }
    
    func delay(_ seconds: Int, closure: @escaping ()->()) {
        let time = DispatchTime.now() + .seconds(seconds)
        DispatchQueue.main.asyncAfter(deadline: time) {
            print("🕑")
            closure()
        }
    }
    
    //MARK: Captured variables are evaluated on execution
    func defaultEvaluatedOnExecutionForClass() {
        var pokemon = Pokemon(name: "Pikachu")
        print("before closure: \(pokemon)")
        delay(1) {
            print("inside closure: \(pokemon)")
        }
        pokemon = Pokemon(name: "Mewtwo")
        print("after closure: \(pokemon)")
    }
    
    func defaultEvaluatedOnExecutionForValue() {
        var value = 42
        print("before closure: \(value)")
        delay(1) {
            print("inside closure: \(value)")
        }
        value = 1337
        print("after closure: \(value)")
    }
    
    //MARK: You can modify captured values in closures
    //Note that if the captured value is a var (and not a let), you can also modify the value from within the closure
    //compare to objc's __block feature
    func changeValueByDefault() {
        var value = 42
        print("before closure: \(value)")
        delay(1) {
            print("inside closure 1, before change: \(value)")
            value = 1337
            print("inside closure 1, after change: \(value)")
        }
        delay(2) {
            print("inside closure 2: \(value)")
        }
    }
    
    //MARK: Capturing a variable as a constant copy
    func captureAsCopiedValue() {
        var value = 42
        print("before closure: \(value)")
        delay(1) { [constValue = value] in
            print("inside closure: \(constValue)")
        }
        value = 1337
        print("after closure: \(value)")
    }
    func captureAsCopiedReference() {
        var pokemon = Pokemon(name: "Pikachu")
        print("before closure: \(pokemon)")
        delay(1) { [pokemonCopy = pokemon] in
            print("inside closure: \(pokemonCopy)")
        }
        pokemon = Pokemon(name: "Mewtwo")
        print("after closure: \(pokemon)")
    }
    
    //MARK:  Mix it all
    //exam
    func exam() {
        var pokemon = Pokemon(name: "Mew")
        print("➡️ Initial pokemon is \(pokemon)") //Mew
        
        delay(1) { [capturedPokemon = pokemon] in
            print("closure 1 — pokemon captured at creation time: \(capturedPokemon)") //Mew
            print("closure 1 — variable evaluated at execution time: \(pokemon)") //Mewtwo
            pokemon = Pokemon(name: "Pikachu")
            print("closure 1 - pokemon has been now set to \(pokemon)")  //Picachu
        }
        
        pokemon = Pokemon(name: "Mewtwo")
        print("🔄 pokemon changed to \(pokemon)") //Mewtwo
        
        delay(2) { [capturedPokemon = pokemon] in
            print("closure 2 — pokemon captured at creation time: \(capturedPokemon)") //Mewtwo
            print("closure 2 — variable evaluated at execution time: \(pokemon)") //Picachu
            pokemon = Pokemon(name: "Charizard")
            print("closure 2 - value has been now set to \(pokemon)") //Charizard
        }
    }
    
}










