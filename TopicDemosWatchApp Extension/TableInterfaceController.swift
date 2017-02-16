//
//  TableInterfaceController.swift
//  TopicDemos
//
//  Created by Sida Wang on 2/15/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

import WatchKit
import Foundation


class TableInterfaceController: WKInterfaceController {

    @IBOutlet var table: WKInterfaceTable!
    
    //https://makeapppie.com/2015/08/20/swift-watchkit-headers-footers-and-more-multiple-row-types-in-apple-watch-tables/
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        table.setRowTypes(["MainRowType","MainRowType","MainRowType","MainRowType","MainRowType", "InfoRowType","InfoRowType","InfoRowType","InfoRowType","InfoRowType","InfoRowType"])
       // table.setNumberOfRows(5, withRowType: "MainRowType") //for only one type of table
        for i in 0..<5 {
            let row: MainRowType = table.rowController(at: i) as! MainRowType
            row.label.setText("hello world long text")
            row.button.setTitle("btn")
        }
       // table.setNumberOfRows(5, withRowType: "InfoRowType")
        for i in 5..<10 {
            let row: InfoRowType = table.rowController(at: i) as! InfoRowType
            row.label.setText("text world long hello")
        }
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

    
}
