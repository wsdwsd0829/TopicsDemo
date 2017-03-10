//
//  ChildXibViewController.swift
//  TopicDemos
//
//  Created by Max Wang on 3/9/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

import UIKit

class ChildXibViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    init() {
        super.init(nibName: "\(type(of: self))", bundle: Bundle(for: type(of: self))) //
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func viewDidAppear(_ animated: Bool) {
         super.viewDidAppear(animated)
       // let vc = ChildXibViewController(nibName: "\(type(of: self))", bundle: Bundle(for: type(of: self)))
    }

}





















