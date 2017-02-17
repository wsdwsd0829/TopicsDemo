//
//  TableInterfaceController.swift
//  TopicDemos
//
//  Created by Sida Wang on 2/15/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

import WatchKit
import Foundation

//TODO: Read Through https://developer.apple.com/reference/watchkit/wkinterfacetable

class TableInterfaceController: WKInterfaceController {

    @IBOutlet var table: WKInterfaceTable!
    
    //https://makeapppie.com/2015/08/20/swift-watchkit-headers-footers-and-more-multiple-row-types-in-apple-watch-tables/
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        table.setRowTypes(["MainRowType", "InfoRowType","ImageRowType"])
       // table.setNumberOfRows(5, withRowType: "MainRowType") //for only one type of table
        for i in 0..<1 {
            let row: MainRowType = table.rowController(at: i) as! MainRowType
            row.label.setText("hello world long text")
            row.button.setTitle("btn")
        }
       // table.setNumberOfRows(5, withRowType: "InfoRowType")
        for i in 1..<2 {
            let row: InfoRowType = table.rowController(at: i) as! InfoRowType
            row.label.setText("text world long hello")
        }
        
        for i in 2..<3 {
            let row: ImageRowType = table.rowController(at: i) as! ImageRowType
            let image = UIImage(named: "placeholder.png")
            
            row.image.setImage(image) //only work when in extension  //??? not work when in asset
            
            //row.image.setImageNamed("placeholder")  //works & load data from watch bundle directly(not extension)
            row.image.setWidth(100)
            row.image.setHeight(100)
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
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        print("\(rowIndex)")
    }
    
}
























