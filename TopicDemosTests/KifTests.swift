//
//  KIFTests.swift
//  TopicDemos
//
//  Created by Max Wang on 5/16/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

import XCTest
import KIF
//!!! must added to UnitTestTarget instead of UITest
class KifTests: KIFTestCase {
    override func beforeAll() {
        super.beforeAll()
    }
    
    override func beforeEach() {
        super.beforeEach()
    }
    //    override func setUp() {
    //        super.setUp()
    //
    //        // Put setup code here. This method is called before the invocation of each test method in the class.
    //
    //        // In UI tests it is usually best to stop immediately when a failure occurs.
    //        continueAfterFailure = false
    //        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    //        XCUIApplication().launch()
    //
    //        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    //    }
    //
    //    override func tearDown() {
    //        // Put teardown code here. This method is called after the invocation of each test method in the class.
    //        super.tearDown()
    //    }
    
    func testExample() {
        
        tester().waitForView(withAccessibilityLabel: "UITesting")
        tester().tapView(withAccessibilityLabel: "UITesting")
        tester().swipeView(withAccessibilityLabel: "Cell row index: 0 cat", in: .left)
        tester().tapView(withAccessibilityLabel: "Delete")
        
        tester().swipeView(withAccessibilityLabel: "Cell row index: 2 snake", in: .left)
        tester().tapView(withAccessibilityLabel: "Delete")
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}

extension XCTestCase {
    func tester(file : String = #file, _ line : Int = #line) -> KIFUITestActor {
        return KIFUITestActor(inFile: file, atLine: line, delegate: self)
    }
    
    func system(file : String = #file, _ line : Int = #line) -> KIFSystemTestActor {
        return KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
    }
}

extension KIFTestActor {
    func tester(file : String = #file, _ line : Int = #line) -> KIFUITestActor {
        return KIFUITestActor(inFile: file, atLine: line, delegate: self)
    }
    
    func system(file : String = #file, _ line : Int = #line) -> KIFSystemTestActor {
        return KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
    }
}
