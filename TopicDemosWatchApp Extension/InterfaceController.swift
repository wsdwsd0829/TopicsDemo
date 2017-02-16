//
//  InterfaceController.swift
//  TopicDemosWatchApp Extension
//
//  Created by Sida Wang on 2/14/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        // Configure interface objects here.
    }
    
    //when set segue in storyboard use this to set data context
    override func contextForSegue(withIdentifier segueIdentifier: String) -> Any? {
        return ["key" : "value"]
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    
    //!! cannot co-exist with Page Based
    @IBAction func nextPageClicked() {
        self.pushController(withName: "FirstPageInterfaceController", context: ["key":"value"])
    }
    
    @IBAction func present() {
        //presentController(withName: "ModalInterfaceController", context: ["key":"value"])
        presentController(withNames: ["ModalInterfaceController", "ModalInterfaceController2"], contexts: [["key":"value"], []])
    
    }
    
}
