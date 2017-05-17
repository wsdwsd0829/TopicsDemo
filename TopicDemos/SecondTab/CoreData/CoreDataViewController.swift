//
//  CoreDataViewController.swift
//  TopicDemos
//
//  Created by Sida Wang on 5/16/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

import UIKit
import CoreData
class CoreDataViewController: UIViewController {

    var cdStack: CoreDataStack!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cdStack = CoreDataStack()
        cdStack.setup()
        
    }
    
    @IBAction func save(_ sender: Any) {
        guard let mood: Mood = NSEntityDescription.insertNewObject(forEntityName: "Mood", into: cdStack.mainContext) as? Mood else {
            fatalError("cannot create mood")
        }
        mood.date = Date()
        mood.updateAt = Date()
        mood.name = "happy"
        
        cdStack.mainContext.perform {
            try! self.cdStack.mainContext.save()
        }
        
        print(mood)
    }
    
    @IBAction func update(_ sender: Any) {
        
    }
    
    @IBAction func deleteAll(_ sender: Any) {
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
