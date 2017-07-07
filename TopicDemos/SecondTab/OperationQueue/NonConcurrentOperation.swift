//
//  NonConcurrentOperation.swift
//  TopicDemos
//
//  Created by Sida Wang on 7/6/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

import UIKit

class NonConcurrentOperation: Operation {
    init(name: String) {
        super.init()
        self.name = name
    }
    override func main() {
        sleep(2)
        print(self.name ?? "")
    }
}
