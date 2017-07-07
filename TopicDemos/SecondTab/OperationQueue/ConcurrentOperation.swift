//
//  ConcurrentOperation.swift
//  TopicDemos
//
//  Created by Sida Wang on 7/5/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

import UIKit
import Helper
/*  sum
 //isReady contains check for dependencies, other wise need custom
 //cancel/finish -> isFinish/isExecuting;
  */
class ConcurrentOperation: Operation {
    init(name: String) {
        super.init()
        self.name = name
    }
    
    override var isAsynchronous: Bool {
        return true
    }
    
    var _executing = false {
        willSet {
            willChangeValue(forKey: "isExecuting")
        }
        didSet {
            didChangeValue(forKey: "isExecuting")
        }
    }
    
    var _finished = false {
        willSet {
            willChangeValue(forKey: "isFinished")
        }
        
        didSet {
            didChangeValue(forKey: "isFinished")
        }
    }
    
    override var isExecuting: Bool {
        return _executing
    }
    
    override var isFinished: Bool {
        return _finished
    }
    
    override func start() {
        if isReady {
            _executing = true
            main()
        } else {
            delay(1) {
                self.start()
            }
        }
    }
    
    override func main() {
        sleep(1)
        DispatchQueue.global().async {
            sleep(2)
            print(self.name ?? "")
            self._finished = true
            self._executing = false
        }
    }
}
