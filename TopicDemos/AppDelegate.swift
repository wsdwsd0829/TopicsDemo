//
//  AppDelegate.swift
//  TopicDemos
//
//  Created by Sida Wang on 2/8/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import Intents
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        verifyAudioPlaybackAvailable()
        //MARK: request siriKit
        INPreferences.requestSiriAuthorization() { status in
            switch status {
            case .authorized: self.handleSiriAuthorized()
            default: print("siri must authorized to work")
            }
        }
        return true
    }
    
    func handleSiriAuthorized() {
        print("siri authorized")
        
    }
}

//MARK: AVFoundation & AVKit
extension AppDelegate {
    func verifyAudioPlaybackAvailable() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayback)
        }
        catch {
            print("Setting category to AVAudioSessionCategoryPlayback failed.")
        }
    }
}

