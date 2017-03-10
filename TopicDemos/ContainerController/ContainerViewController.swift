//
//  ContainerViewController.swift
//  TopicDemos
//
//  Created by Max Wang on 2/22/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    //ChildXibViewController(nibName: nil, bundle: nil)  //works only override parent, otherwise custom controller init will mask default init(nibName, bundle)
    let childVC = ChildXibViewController() //use custome init to hide initWithNib;

    //To load from storyboard use following: 
    //UIStoryboard(name: "ContainerController", bundle: nil).instantiateViewController(withIdentifier: "ChildViewController")

    override func viewDidLoad() {
        super.viewDidLoad()
        let aview = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        aview.backgroundColor = UIColor.green
        childVC.view.addSubview(aview)
        childVC.view.backgroundColor = UIColor.blue
        childVC.view.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        childVC.label.text = "custom text for xib controller"
        addChildController()
    }

    func addChildController() {
        childVC.willMove(toParentViewController: self)
        view.addSubview(childVC.view)
        addChildViewController(childVC)
        childVC.didMove(toParentViewController: self)
    }
    
    func removeChildController() {
        childVC.willMove(toParentViewController: nil)
        childVC.removeFromParentViewController()
        childVC.view.removeFromSuperview()
        childVC.didMove(toParentViewController: nil)
    }
    @IBAction func removeBtnClicked(_ sender: UIButton) {
        removeChildController()
    }
}
