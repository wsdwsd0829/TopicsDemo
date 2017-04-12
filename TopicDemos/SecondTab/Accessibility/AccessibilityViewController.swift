//
//  AccessibilityViewController.swift
//  TopicDemos
//
//  Created by Max Wang on 4/10/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

import UIKit

class AccessibilityViewController: UIViewController {

    @IBOutlet var button: UIButton!
    @IBOutlet var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(accessibilityChanged), name: NSNotification.Name(rawValue: UIAccessibilityVoiceOverStatusChanged), object: nil)
        
        if (UIAccessibilityIsVoiceOverRunning()) {
            self.label.text = "is running"
        } else {
            self.label.text = "is not running"
        }
        NSLog("\(self.label.text)")
        becomeFirstResponder()
    }
    
    //MARK: detect accessibility changes (UIAccessibilityVoiceOverStatusChanged)
    func accessibilityChanged() {
        if UIAccessibilityIsVoiceOverRunning() {
            self.label.text = "UIAccessibilityIsVoiceOverRunning true"
        } else {
            self.label.text = "UIAccessibilityIsVoiceOverRunning false"
        }
    }
    
    @IBAction func btnClicked(_ sender: UIButton!) {
        //for voice over also
        self.label.text = "Button Clicked"
    }
    
    //MARK: Magic Gestures
    override func accessibilityPerformEscape() -> Bool {
        
        //two finger scrub
        return true
    }
    override func accessibilityPerformMagicTap() -> Bool {
        //two finger double tap
        //will call here and trigger audio also
        
        // will also trigger music ???
        return false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //MARK: Elem accessibility
        self.label.isAccessibilityElement = true
        self.label.accessibilityLabel = "Apple Inc., $432.39, up 1.3%" //label no period, sep by ,
        self.label.accessibilityLabel = "Label hint can be very long." //hint has period
        self.label.accessibilityIdentifier = "label identifier in code"
        
        //MARK: Change First Element
        UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, button)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
