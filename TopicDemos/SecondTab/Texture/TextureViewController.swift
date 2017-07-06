//
//  TextureViewController.swift
//  TopicDemos
//
//  Created by Sida Wang on 7/4/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

import UIKit

class TextureViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        //create view at background thread; -> so far so good, Texture says cannot
        DispatchQueue.global().async {
            let newView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            newView.backgroundColor = UIColor.red
            DispatchQueue.main.async {
                self.view.addSubview(newView)
            }
        }
    }
}
