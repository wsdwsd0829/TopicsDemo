//
//  TemplateViewController.swift
//  TopicDemos
//
//  Created by Sida Wang on 2/26/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

import UIKit
import Helper

class TemplateViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("string".name)
        print(("Str" as NSString).objcname())
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
