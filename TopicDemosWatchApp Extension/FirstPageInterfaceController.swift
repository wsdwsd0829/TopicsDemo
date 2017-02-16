//
//  FirstPageInterfaceController.swift
//  TopicDemos
//
//  Created by Sida Wang on 2/15/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

import WatchKit
import Foundation


class FirstPageInterfaceController: WKInterfaceController {
    @IBOutlet var label: WKInterfaceLabel!

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        self.becomeCurrentPage()
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    @IBAction func backClicked() {
        
    }
    @IBAction func g1Clicked() {
        self.label.setText("g1")
    }
    
    @IBAction func g2Clicked() {
        self.label.setText("g2")
    }
    
}
