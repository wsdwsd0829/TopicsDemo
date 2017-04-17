//
//  AnimatedViewController.swift
//  TopicDemos
//
//  Created by Sida Wang on 4/16/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

import UIKit

class AnimatedViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.green
    }

    @IBAction func cancelClicked(_ sender: AnyObject) {
        if presentingViewController != nil {
            //TODO: presentingViewController is not CustomPresentAnimateViewController
           let presenting = (self.presentingViewController as? CustomPresentAnimateViewController)
            presenting?.shouldInteractive = false
            dismiss(animated: true, completion: {
                presenting?.shouldInteractive = true
            })
        } else if let nvc = navigationController {
            if nvc.viewControllers.count > 1 {
                nvc.popViewController(animated: true)
            }
        }
    }
}
