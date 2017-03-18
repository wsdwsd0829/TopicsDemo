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
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var networkService: NetworkService!
    
    struct Constants {
        static let userId = "kUserId"
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        verifyAudioPlaybackAvailable()

        //MARK: Firebase
        FIRApp.configure()
        networkService = FirebaseService.shared

        if let user = FIRAuth.auth()?.currentUser {
            print("user login")
            testSaveAndFetch(user)
        } else {
            print("user logout")
        }
        //MARK: request siriKit
        INPreferences.requestSiriAuthorization() { status in
            switch status {
            case .authorized: self.handleSiriAuthorized()
            default: print("siri must authorized to work")
            }
        }
        
        //MARK: design pattern practice
        PatternCenter.shared.testObserverPattern()
        PatternCenter.shared.testCommandPattern()
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

