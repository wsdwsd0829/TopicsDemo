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
    var shouldShowCancel: Bool = false
    static func getOne() -> TemplateViewController {
        // NSStringFromClass(TemplateViewController.self)
        let storyboard = UIStoryboard(name: "Template", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "TemplateViewController") as! TemplateViewController
        //return TemplateViewController(nibName: "TemplateViewController", bundle: nil)
    }
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //must be called after viewDidLoad
        navigationController?.setNavigationBarHidden(false, animated: true)
        print("string".name)
        print(("Str" as NSString).objcname())
        self.label.text = "ViewDidLoad"
        
        if self.navigationController != nil {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClicked(_:)))
        } else if shouldShowCancel {
            let cancelButton = UIButton(frame: CGRect(x: 10, y: 100, width: 200, height: 40))
            cancelButton.setTitle("Cancel Button", for: .normal)
            cancelButton.addTarget(self, action: #selector(cancelClicked(_:)), for: .touchUpInside)
            cancelButton.backgroundColor = UIColor.green
            cancelButton.setTitleColor(UIColor.blue, for: .normal)
            self.view.addSubview(cancelButton)

        }
            // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
 
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
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
