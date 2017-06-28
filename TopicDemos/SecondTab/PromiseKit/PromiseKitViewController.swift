//
//  PromiseKitViewController.swift
//  TopicDemos
//
//  Created by Sida Wang on 3/12/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

import UIKit
import PromiseKit
import CoreLocation
import Helper
class PromiseKitViewController: UIViewController {
   typealias VoidHandler = () -> ()
    var manager: CLLocationManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        //e.g. of creating dispatch queue
        edgesForExtendedLayout = []
        if #available(iOS 10.0, *) {
            let _ = DispatchQueue(label: "myq", qos: .background, attributes: [.concurrent], autoreleaseFrequency: .workItem, target: DispatchQueue.main)
        } else {
            // Fallback on earlier versions
        }

        delay2(sec: 3)
        /*
        _ = delay(sec: 3).then { _ -> Void in
            print("delayed: 3 seconds")
            print("finished")
        }
        _ = firstly {
            after(interval: 4).then() {
                print("delayed 4 seconds")
            }
        }
        */
        // Do any additional setup after loading the view.

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func delay(sec: TimeInterval) -> Promise<Void> {
        return Promise { fulfill, reject in
            DispatchQueue.main.asyncAfter(deadline: .now() + sec) {
                _ = fulfill()
            }
        }
    }
    
    func delay2(sec: TimeInterval) {
        Promise<Void> { fulfill, reject in
            print(" promise executed \(Date())")
            DispatchQueue.main.asyncAfter(deadline: .now() + sec) {
                _ = fulfill()
                print(" promise fulfill \(Date())")
            }
        }
    }
    
    @IBAction func tapLocatinRequest(_ sender: UIButton!) {
        CLLocationManager.locationServicesEnabled()
        manager = CLLocationManager()
        //                if CLLocationManager.locationServicesEnabled() {
        //                    manager.startUpdatingLocation()
        //                }
        if CLLocationManager.authorizationStatus() == .notDetermined {
            manager.requestWhenInUseAuthorization()
        }
        Utils.showAlert(from: self)
        sleep(1)
        Utils.showAlert(from: self, title: "titile 2", message: "new msg")
    }
}
