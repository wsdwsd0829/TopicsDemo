//
//  OperationQueueViewController.swift
//  TopicDemos
//
//  Created by Sida Wang on 7/5/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

import UIKit

class OperationQueueViewController: UIViewController {
    var queue: OperationQueue!
    override func viewDidLoad() {
        super.viewDidLoad()
//        testPriority()
        testDependencyForConcurrent()
    }
    
    //MARK: Non Concurrent Operation
    func testPriority() {
        queue = OperationQueue()
        
        let operationA = NonConcurrentOperation(name: "A")
        let operationB = NonConcurrentOperation(name: "B")
        let operationC = NonConcurrentOperation(name: "C")
        queue.isSuspended = true
        operationC.queuePriority = .veryHigh  //BCA, ACB, ABC; //after: CAB, BAC, CBA, CAB(isSuspended to allow queue to make decision otherwise execute imeediately)
        queue.addOperation(operationA)
        queue.addOperation(operationB)
        queue.addOperation(operationC)
        sleep(2)
        queue.isSuspended = false
    }
    
    func testDependency() {
        queue = OperationQueue()
        let operationA = NonConcurrentOperation(name: "A")
        let operationB = NonConcurrentOperation(name: "B")
        let operationC = NonConcurrentOperation(name: "C")
        
        operationC.queuePriority = .high
        operationB.addDependency(operationC)
        operationC.addDependency(operationA) //B->C->A
        DispatchQueue.global().async {
            self.queue.addOperation(operationB)
            sleep(1)
            self.queue.addOperation(operationC)
            sleep(1)
            self.queue.addOperation(operationA)
        }
    }
    
    //MARK: Concurrent Operation
    func testDependencyForConcurrent() {
        queue = OperationQueue()
        
        let operationA = ConcurrentOperation(name: "A")
        let operationB = ConcurrentOperation(name: "B")
        let operationC = ConcurrentOperation(name: "C")
        
        operationC.queuePriority = .high
        operationB.addDependency(operationC)
        operationC.addDependency(operationA)
        DispatchQueue.global().async {
            operationB.start()
            sleep(2)
            operationC.start()
            sleep(2)
            operationA.start()
        }
    }
}
