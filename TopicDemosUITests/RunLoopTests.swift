//
//  RunLoopTests.swift
//  TopicDemos
//
//  Created by Max Wang on 6/15/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

import XCTest

@testable import TopicDemos
class RunLoopTests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = true
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testElementQueryHaveAbout2SecondToWaitForElement() {
        
        XCUIApplication().tables.cells.staticTexts["UITesting"].tap()
        let app = XCUIApplication()
        
        let label = app.staticTexts["id2"]
        let exists = NSPredicate(format: "exists == 1")
        
        self.expectation(for: exists, evaluatedWith: label, handler: nil)
        self.waitForExpectations(timeout: 3, handler: nil)
        
        let id2 = app.staticTexts["id2"]
        XCTAssert(id2.isHittable)
        id2.tap()
        
        //test elem has about 2 second to wait for by default 
        for i in 1...5 {
            let newCount = 2 + i*2
            let newId = "id\(newCount)"
            let elem = app.staticTexts[newId]
            XCTAssertTrue(elem.isHittable)
        }
        
        XCTAssertFalse(app.staticTexts["id100"].exists)
        
    }
    
    //exist -> soft fail, isHittable -> hard fail
    func testExistHittable() {
        XCUIApplication().tables.cells.staticTexts["UITesting"].tap()
        let app = XCUIApplication()
        var ex = app.staticTexts["id7"].exists
        let id7 = app.staticTexts["id7"]
        print("-------" + id7.debugDescription)
        print("-------" + app.staticTexts["id1"].debugDescription)
        
        if id7.isHittable { //this will cause an direct fail
            print("detected whether hittable")
        }
    }
    
    func testFailBag() {
        FailBag().fail()
    }
    
    override func recordFailure(withDescription description: String, inFile filePath: String, atLine lineNumber: UInt, expected: Bool) {
        if let fail = FailBag.failures.first {
            super.recordFailure(withDescription: "hello", inFile: fail.file!, atLine: UInt(fail.line!), expected: expected)
            return
        }
        super.recordFailure(withDescription: description, inFile: filePath, atLine: lineNumber, expected: expected)
    }
}

public extension RunLoop {
    /// This behaves like waitForExpectation, but gives us more control over performance
    @discardableResult
    func loopUntil(timeout: TimeInterval, pollingInterval: TimeInterval = 0.01, condition: () -> Bool) -> Bool {
        let endDate = Date(timeIntervalSinceNow: timeout)
        let punishTime = 0.02
        var interval = pollingInterval
        while Date().compare(endDate) == .orderedAscending {
            if condition() {
                return true
            }
            if pollingInterval > 0 {
                run(until: Date(timeIntervalSinceNow: interval))
                interval += punishTime
                print("interval: \(interval), pollingInterval: \(pollingInterval), punishTime: \(punishTime), data: \(Date())")
            }
        }
        
        return false
    }
}







