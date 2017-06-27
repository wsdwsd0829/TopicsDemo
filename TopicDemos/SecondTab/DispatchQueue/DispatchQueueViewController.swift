//
//  DispatchQueueViewController.swift
//  TopicDemos
//
//  Created by Sida Wang on 6/25/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

import UIKit

class DispatchQueueViewController: UIViewController {
    var moveView: UIView!
    var isAnimating: Bool = false
    
    //MARK: GCD test
    /**
     test combine sync/async + serial/concurrent
     */
    func serialSync() {
        let q = DispatchQueue(label: "serial.sync")
        //https://stackoverflow.com/questions/26020656/dispatch-sync-always-execute-block-in-main-thread
        //The calling thread is blocked -- can't do a thing -- until dispatch_sync() returns
        q.sync { //Document Says:  As an optimization, this function invokes the block on the current thread when possible.
            //source code Says: It's preferred to execute synchronous blocks on the current thread due to thread-local side effects, garbage collection, etc. However, blocks submitted to the main thread MUST be run on the main thread.
            for i in 0..<5 { //!!! so: will block UI

                sleep(1)
                print(i)
            }
        }
        print("returned from Sync")
    }
    
    func serialAsync() {
        let q = DispatchQueue(label: "serial.async")
        q.async { //will execute on a different thread
            for i in 0..<5 {
                sleep(1)
                print(i)
            }
        }
        q.async {
            for i in 5..<10 { //will after 0-4
                sleep(1)
                print(i)
            }
        }
        print("returned from SerialAsync") //called before count
    }
    
    func concurrentSync() {
        let q = DispatchQueue(label: "concurrent.sync", qos: .background, attributes: [.concurrent], autoreleaseFrequency: .inherit, target: DispatchQueue.global(qos: .background))
        //for target param: https://developer.apple.com/documentation/dispatch/dispatchobject/1452989-settarget
        q.sync { //same as serial sync
            for i in 0..<5 {
                sleep(1)
                print(i)
            }
        }
        q.sync {
            for i in 5..<10 { //will after 0-4
                sleep(1)
                print(i)
            }
        }
        print("returned from ConcurrentSync") //called before count
    }
    
    func concurrentAsync() {
        let q = DispatchQueue(label: "concurrent.sync", qos: .background, attributes: [.concurrent], autoreleaseFrequency: .inherit, target: DispatchQueue.global(qos: .background))
        q.async {
            for i in 0..<5 {
                sleep(1)
                print(i)
            }
        }
        q.async {
            for i in 5..<10 { //interleaved with 0-4
                sleep(1)
                print(i)
            }
        }
        print("returned from ConcurrentSync") //called before count
    }
    /**
    //MARK: test combine sync & async
    */
    func syncInAsync() {
        let q1 = DispatchQueue(label: "serial.async2")
        q1.async { //will execute on a different thread
            let q2 = DispatchQueue(label: "serial.sync2")
            for i in 0...5 {
                q2.sync {  //!!!if change q2 to q1 will deadlock: sync wait outer async to finish
                    sleep(1)
                    print(i)  //print 0-5 in order, not blocking UI  //same for concurrent q1
                }
            }
        }
    }
    
    func asyncSerialInSync() {
        let q1 = DispatchQueue(label: "serial.async2")
        q1.sync { //will execute on a different thread
            for i in 0...5 {
                q1.async {
                    sleep(1)
                    print(i)  //print 0-5 in order, blocking main but super short UI
                }
            }
        }
    }
    
    func asyncConcurrentInSync() {
        let q1 = DispatchQueue(label: "serial.async2")
        q1.sync { //will execute on a different thread
             let q2 = DispatchQueue(label: "concurrent.sync2", qos: .background, attributes: [.concurrent], autoreleaseFrequency: .inherit, target: DispatchQueue.global(qos: .background))
            sleep(3)
            for i in 0...5 {
                q2.async {
                    sleep(1)
                    print(i)  //not in order, but simutaneously, blocking main UI
                }
            }
        }
    }
    /**
     test access shared resource
     */
    var sharedArr = [Int]()
    //print in order comparing to next method
    func writeToArrFromSerial() {
        let q1 = DispatchQueue(label: "serial.write")
        let q2 =  DispatchQueue(label: "serial.read")
        
        for i in 0...10 {
            q1.async {
                sleep(1)
                self.sharedArr.append(i)
                q2.sync(execute: {
                    print(self.sharedArr)
                })
            }
        }
    }
    
    //may out of order comparing to prev method
    func writeToArrFromConcurrent() {
        let q1 = DispatchQueue(label: "concurrent.write", qos: .background, attributes: [.concurrent], autoreleaseFrequency: .inherit, target: DispatchQueue.global(qos: .background))
        let q2 = DispatchQueue(label: "serial.read")
        print(q2)
        let arrayLock = NSLock()
        for i in 0...10 {
            q1.async {
                //if no lock -> pointer being freed was not allocated, cannnot write async -> need lock
                //another sol: put to serial q;
                
                //way 1
                arrayLock.lock()
                self.sharedArr.append(i)
                print(self.sharedArr)
                arrayLock.unlock()
                //way 2
                /*
                q2.sync(execute: {
                    self.sharedArr.append(i)
                    print(self.sharedArr)
                })
                 */
            }
        }
    }

    
    //MARK: Set view animation
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        moveView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        moveView.backgroundColor = .blue
        view.addSubview(moveView)
        animationBtn()
        //MARK: start test
        writeToArrFromSerial()
        writeToArrFromConcurrent()
    }
    
    @IBAction func animationBtn() {
        if isAnimating {
            moveView.layer.removeAllAnimations()
            moveView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            isAnimating = false
        } else {
            UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .autoreverse, .allowUserInteraction, .curveLinear], animations: {
                self.moveView.frame = CGRect(x: 200, y: 0, width: 50, height: 50)
            }) { (success) in
                
            }
            isAnimating = true
        }
    }

}


