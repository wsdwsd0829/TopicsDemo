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
#if TARGET_IOS
#endif
//@UIApplicationMain -> replaced with main.swift cause subclass UIApplication; cannot co-exist
//https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Attributes.html
//http://stackoverflow.com/questions/24516250/what-does-uiapplicationmain-means
class AppDelegate: UIApplication, UIApplicationDelegate {  //change UIResponder with UIApplication, must init window by self
    var window: UIWindow?
    var networkService: NetworkService!
    struct Constants {
        static let userId = "kUserId"
    }
    //UIApplication Methods
    override func sendEvent(_ event: UIEvent) {
        super.sendEvent(event)
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        window?.makeKeyAndVisible()
        
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
        if #available(iOS 10.0, *) {
            INPreferences.requestSiriAuthorization() { status in
                switch status {
                case .authorized: self.handleSiriAuthorized()
                default: print("siri must authorized to work")
                }
            }
        } else {
            // Fallback on earlier versions
        }
        
        //MARK: design pattern practice
        PatternCenter.shared.testObserverPattern()
        PatternCenter.shared.testCommandPattern()
        RunLoop.current.loopUntil(condition: { return false }, timeout: 1)
        //MARK: Bridging related test
        ObjcTesting.useSwift()
        return true
    }
    
    func handleSiriAuthorized() {
        print("siri authorized")
    }
}
//MARK: save and restore
extension AppDelegate {
    func application(application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
        return true
    }
    
    func application(application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
        return true
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

