//
//  Testing.swift
//  TopicDemos
//
//  Created by Max Wang on 3/14/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

import Foundation

@objc class MyDirectionBridge: NSObject {
    public class func name(direction: MyDirection) -> String {
        switch direction {
        case .north: return "north"
        case .west: return "west"
        case .south: return "south"
        case .east: return "east"
        }
    }
}
@objc
public enum MyDirection: Int {
    case north, west, south, east
    public func name() -> String {
        switch self {
        case .north: return "north"
        case .west: return "west"
        case .south: return "south"
        case .east: return "east"
        }
    }
}
//cannot be used in
enum Direction {
    case north(Int), west, south, east
}
//Rename class name used in objc-> See usage in EmailViewController
@objc(PMTesting)
class Testing: NSObject {
    public let title = "title"
}
