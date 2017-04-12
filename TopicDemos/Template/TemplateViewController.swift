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
    
    static func getOne() -> TemplateViewController {
        // NSStringFromClass(TemplateViewController.self)
        let storyboard = UIStoryboard(name: "Template", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "TemplateViewController") as! TemplateViewController
        //return TemplateViewController(nibName: "TemplateViewController", bundle: nil)
    }
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("string".name)
        print(("Str" as NSString).objcname())
        self.label.text = "ViewDidLoad"
        
        if self.navigationController != nil {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClicked(_:)))
        }
            // Do any additional setup after loading the view.
    }

    func cancelClicked(_ sender: AnyObject) {
        if presentingViewController != nil {
           dismiss(animated: true, completion: nil)
        } else if let nvc = navigationController {
            if nvc.viewControllers.count > 1 {
                nvc.popViewController(animated: true)
            }
        }
    }

}
