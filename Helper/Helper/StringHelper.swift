//
//  StringHelper.swift
//  Helper
//
//  Created by Max Wang on 2/28/17.
//  Copyright © 2017 Max Wang. All rights reserved.
//

import Foundation
extension String {
   public var name: String {
        return "a name"
    }
}
extension RunLoop {
    /// This behaves like waitForExpectation, but gives us more control over performance
    public func loopUntil(condition:(() -> Bool), timeout: TimeInterval) {
        let endDate = NSDate(timeIntervalSinceNow: timeout)
        while (NSDate().compare(endDate as Date) == .orderedAscending) {
            if (condition()) {
                return
            }
            print(Date())
            RunLoop.current.run(until: NSDate(timeIntervalSinceNow: 1) as Date)
        }
    }
}
