//
//  Mood.swift
//  TopicDemos
//
//  Created by Sida Wang on 5/16/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

import UIKit
import CoreData

class Mood: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var date: Date
    @NSManaged var updateAt: Date
    @NSManaged var image: Data?
    @NSManaged var colors: Data?
}
