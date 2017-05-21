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

class CoreDataStack2: NSObject {
    var pc: NSPersistentContainer!
    var mainContext: NSManagedObjectContext!

    static let storeName = "Moody.sqlite"
    static let modelName = "Mood"
    
    func setup() {
        pc = NSPersistentContainer(name: CoreDataStack2.modelName)
        let sd = NSPersistentStoreDescription(url: storeURL(withName: CoreDataStack2.storeName))
        pc.persistentStoreDescriptions = [sd]
        mainContext = pc.viewContext
        //if not set store Descriptions use default modelName(Mood) + sqlite type in Application Support
        pc.loadPersistentStores { (storeDesc, err) in
            if err != nil {
                print(err!)
            }
        }
    }
    
    fileprivate func storeURL(withName name: String) -> URL {
        guard let baseUrlStr = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
            fatalError("no application Dir")
        }
        let url = URL(fileURLWithPath: baseUrlStr).appendingPathComponent(name)
        return url
    }
}
