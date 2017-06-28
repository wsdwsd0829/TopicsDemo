//
//  InterruptionTest.swift
//  TopicDemos
//
//  Created by Max Wang on 6/28/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

import XCTest

class InterruptionTest: XCTestCase {
    var monitors: [NSObjectProtocol]!
    var app: XCUIApplication!
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        setupAlertHandler()
    }
    
    func setupAlertHandler() {
        monitors = [NSObjectProtocol]()
        let monitor1 = addUIInterruptionMonitor(withDescription: "Location Services") { (alert) -> Bool in
            if alert.buttons["Allow"].exists {
                alert.buttons["Allow"].tap()
                return true
            } else {
                return false
            }
        }
        let monitor2 = addUIInterruptionMonitor(withDescription: "Alert") { (alert) -> Bool in
            if alert.buttons["OK"].exists {
                alert.buttons["OK"].tap()
                return true
            } else {
                return false
            }
        }
        
        monitors.append(monitor1)
        monitors.append(monitor2)
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        monitors.forEach {
            removeUIInterruptionMonitor($0)
        }
        monitors = nil
        super.tearDown()
    }
    
    //TODO: Problem: cannot resolve two consecutive interrupt (System -> User initialted) using monitorA
    func testDismissSystemAndCustomAlert() {
        app.tables.cells.staticTexts["PromiseKit"].tap()
        //trigger System Alert
        app.buttons["Button"].tap()
        //handle UIAlert / syster alert will be handled by monitors added in setup!
        app.buttons["OK"].tap()
        app.buttons["Confirm"].tap()  //!must tap sth to trigger handler
    }
}
