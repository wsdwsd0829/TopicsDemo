//
//  TopicDemosUITests.swift
//  TopicDemosUITests
//
//  Created by Sida Wang on 2/8/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

import XCTest

class TopicDemosUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.

    }
    //"Application "com.maxsida.TopicDemos" is installing or uninstalling, and cannot be launched"
    func testExample0() {
        measure {
            let app = XCUIApplication()
            app.launchArguments = ["UITests"]
            app.launch()
            let tablesQuery = XCUIApplication().tables
            tablesQuery.staticTexts["UITesting"].tap()
            tablesQuery.staticTexts["cat"].swipeLeft()
            tablesQuery.buttons["Delete"].tap()
            tablesQuery.staticTexts["snake"].swipeLeft()
            tablesQuery.buttons["Delete"].tap()
            
            super.tearDown()
        }
    }
    
    func testExample1() {
        let app = XCUIApplication()
        app.launch()
        
        let tablesQuery = app.tables
        
        tablesQuery.staticTexts["UITesting"].tap()
        
        //both exists and isHittable fail if hidden
        //still work if element isUserInteractive = false or enabled = false ???
        let button = app.buttons["MyButton"]
        XCTAssertTrue(button.exists)
        XCTAssertTrue(button.isHittable)

        let label = app.staticTexts["Label"]
        XCTAssertTrue(label.isHittable)
        XCTAssertTrue(label.exists)
        
        tablesQuery.staticTexts["cat"].swipeLeft()
        tablesQuery.buttons["Delete"].tap()
        tablesQuery.staticTexts["snake"].swipeLeft()
        tablesQuery.buttons["Delete"].tap()
        
        let row11 = tablesQuery.staticTexts["pig"]
        XCTAssertTrue(row11.exists)
        //http://stackoverflow.com/questions/33573760/ui-automation-how-can-an-element-exists-but-not-be-hittable
        XCTAssertFalse(row11.isHittable)
        
        tablesQuery.element.swipeUp()
        super.tearDown()
    }
}
//Helper
extension TopicDemosUITests {
    /*
     Swift 2.3
    //this will delay test process from finishing; for debugging on lldb
    func pause(seconds: NSTimeInterval = 60, handler: ((NSError?) -> Void)? = nil) {
        let expection = expectationWithDescription("Pause Test For Debugging")
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(seconds * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
            expection.fulfill()
        })
        waitForExpectationsWithTimeout(seconds+10) { (error) in
            print(error?.localizedDescription)
        }
    }
     */
    //this will delay test process from finishing; for debugging on lldb
    func pause(seconds: TimeInterval = 60, handler: ((NSError?) -> Void)? = nil) {
        let expection = expectation(description: "Pause Test For Debugging")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            expection.fulfill()
        }
        waitForExpectations(timeout: seconds+10) { (err) in
            print(err?.localizedDescription ?? "")
        }
    }
}
