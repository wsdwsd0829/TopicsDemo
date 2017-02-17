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
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        if let dict = context as? [String: String] {
             label.setText(dict["key"])
        }
        
        if let videoURL = Bundle.main.url(forResource: "SampleVideo_360x240_2mb", withExtension: "mp4") {
            print("find mp4")
            inlineMovie.setMovieURL(videoURL)
            //inlineMovie.playFromBeginning()
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
    @IBAction func backClicked() {
       self.pop()
    }
    @IBAction func g1Clicked() {
        self.label.setText("g1")
    }
    
    @IBAction func g2Clicked() {
        self.label.setText("g2")
    }
    
}
