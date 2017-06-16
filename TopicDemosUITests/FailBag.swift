//
//  FailBag.swift
//  TopicDemos
//
//  Created by Max Wang on 6/15/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

import Foundation
import XCTest

class FailBag: XCTest {
    var line: Int?
    var file: String?
    static var failures = [FailBag]()
    func fail(file: String = #file, line: Int = #line) {
        let fb = FailBag()
        fb.file = file
        fb.line = line
        FailBag.failures.append(fb)
        
        XCTFail()
    }
}

