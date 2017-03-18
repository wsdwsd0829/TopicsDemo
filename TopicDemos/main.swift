//
//  main.swift
//  TopicDemos
//
//  Created by Max Wang on 3/14/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

import Foundation

//https://forums.developer.apple.com/thread/46405
UIApplicationMain(
    CommandLine.argc,
    UnsafeMutableRawPointer(CommandLine.unsafeArgv).bindMemory(
        to: UnsafeMutablePointer<Int8>.self,
        capacity: Int(CommandLine.argc)),
    NSStringFromClass(AppDelegate.self),
    NSStringFromClass(AppDelegate.self))
