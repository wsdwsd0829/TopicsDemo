//
//  PromiseKitViewController.swift
//  TopicDemos
//
//  Created by Sida Wang on 3/12/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

import UIKit

class PromiseKitViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let q = DispatchQueue(label: "myq", qos: .background, attributes: [.concurrent], autoreleaseFrequency: .workItem, target: DispatchQueue.main)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5, execute: {
            print("after 5 sec")
        })
        print("after dispatch.main.asyncAfter")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
