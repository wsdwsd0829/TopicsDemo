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
    
    func testExample() {
        tester().waitForView(withAccessibilityLabel: "UITesting")
        tester().tapView(withAccessibilityLabel: "UITesting")
        tester().swipeView(withAccessibilityLabel: "cat", in: .left)
        tester().tapView(withAccessibilityLabel: "Delete")
        
        tester().swipeView(withAccessibilityLabel: "snake", in: .left)
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
