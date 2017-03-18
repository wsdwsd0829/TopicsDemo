//
//  ObserverPattern.swift
//  TopicDemos
//
//  Created by Sida Wang on 3/9/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

import UIKit
//MARK: Singleton -> https://krakendev.io/blog/the-right-way-to-write-a-singleton
class PatternCenter {
    static var shared = PatternCenter();
    func testObserverPattern() {
        let center = Center();
        let o1 = Observer1();
        let o2 = Observer1();
        let event = Event();
        event.data = "event data"
        center.addObserver(o1)
        center.notifyEvent(event)
        center.addObserver(o2)
        center.notifyEvent(event)
    }

    func testCommandPattern() {
        let calc = Calculator()
            calc.add(amount: 3)  //3
            calc.multiply(amount: 5) //15
            calc.multiply(amount: 3) //45
            calc.divide(amount: 9) //5
            calc.substract(amount: 2) //3
        while calc.commands.count > 0 {
            calc.commands.removeLast().execute()
            calc.commands.removeLast()
            print(calc.total)
        }
    }
}

//MARK: ObserverPattern
protocol Observerable {
    func receivedEvent(_ event: Event);
}

class Observer1: Observerable {
    func receivedEvent(_ event: Event) {
        print(event.data ?? "no data")
    }
}

class Event {
    var data: String?
}

class Center {
    var observers: [Observerable] = [Observerable]()
    func addObserver(_ observer: Observerable) {
        observers.append(observer);
    }
    func notifyEvent(_ event: Event) {
        observers.forEach {
            $0.receivedEvent(event);
        }
    }
}










