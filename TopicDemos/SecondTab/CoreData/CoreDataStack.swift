//
//  CoreDataStack.swift
//  TopicDemos
//
//  Created by Sida Wang on 5/16/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

import UIKit
import CoreData
class CoreDataStack: NSObject {
    var mainContext: NSManagedObjectContext!
    
    fileprivate var storeCoord: NSPersistentStoreCoordinator!
    static let storeName = "Mood"
    
    func setup() {
        guard let mom = NSManagedObjectModel.mergedModel(from: nil) else {
            fatalError("no mom")
        }
        storeCoord = NSPersistentStoreCoordinator(managedObjectModel: mom)
        mainContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        mainContext.persistentStoreCoordinator = storeCoord
        
        try! storeCoord.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL(withName: "Mood.sqlite"), options: nil)
    }
    
    fileprivate func storeURL(withName name: String) -> URL {
        guard let baseUrlStr = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
            fatalError("no application Dir")
        }
        let url = URL(fileURLWithPath: baseUrlStr).appendingPathComponent(name)
        return url
    }
}
