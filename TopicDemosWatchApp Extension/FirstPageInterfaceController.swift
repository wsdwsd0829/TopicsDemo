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
    @IBOutlet var inlineMovie: WKInterfaceInlineMovie! //OS 3.0
    @IBOutlet var picker: WKInterfacePicker!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        //set up data
        if let dict = context as? [String: String] {
             label.setText(dict["key"])
        }
        //setup video
        if let videoURL = Bundle.main.url(forResource: "SampleVideo_360x240_2mb", withExtension: "mp4") {
            print("find mp4")
            inlineMovie.setMovieURL(videoURL)
            //inlineMovie.playFromBeginning()
        }
        //setup picker -> TODO: percent circle adjusted by crown
        //https://www.bignerdranch.com/blog/watchkit-2-hardware-bits-using-the-digital-crown/
        var items = [WKPickerItem]()
        for i in 0...2 {
        let item = WKPickerItem()
            item.title = "title" + String(i)
            item.caption = "caption" + String(i)
            items.append(item)
        }
        picker.setItems(items)
        picker.focus()
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
       self.pop()
    }
    
    @IBAction func g1Clicked() {
        self.label.setText("g1")
    }
    
    @IBAction func g2Clicked() {
        self.label.setText("g2")
    }
    
    //MARK: Picker: If your app should respond only to the item that the user selected
    override func pickerDidSettle(_ picker: WKInterfacePicker) {
        print("picker selected: \(picker)")
        //get index from picker Action and do expensive op here!!! -> Cannot get index here directly
    }
    @IBAction func pickerAction(_ index: Int) {
        print("picker Scrolled to \(index)")
    }
    //MARK: Context Menu
    
    @IBAction func firstMenuItemClicked() {
        print("firstMenuItemClicked")
    }
    
}
