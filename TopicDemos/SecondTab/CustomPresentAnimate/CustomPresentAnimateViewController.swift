//
//  CustomPresentAnimateViewController.swift
//  TopicDemos
//
//  Created by Sida Wang on 4/15/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

import UIKit
/*
//Summary
1. UIModalPresentationStyle, UIModalTransitionStyle
2. Custom Presentation Style
3. Custom Transition Animation
 */
class CustomPresentAnimateViewController: UIViewController {
    let presentButton = UIButton(frame: CGRect(x: 10, y: 100, width: 200, height: 40))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentButton.setTitle("Present Button", for: .normal)
        presentButton.addTarget(self, action: #selector(presentClicked(_:)), for: .touchUpInside)
        presentButton.backgroundColor = UIColor.green
        presentButton.setTitleColor(UIColor.blue, for: .normal)
        self.view.addSubview(presentButton)
    }

    func presentClicked(_ sender: UIButton) {
        let templateVC = TemplateViewController.getOne()
        //!!!if .popover: need sourceView or sourceRect or barButtonItem for presented
        let modalPresentationStyle: UIModalPresentationStyle = .currentContext
        
        //!!!if .partialCurl: This transition style is supported only if the parent view controller is presenting a full-screen view and you use the UIModalPresentationFullScreen modal presentation style
        let modalTransitionStyle: UIModalTransitionStyle = .flipHorizontal
        
        customPresentStyle(for: templateVC, presentationStyle: modalPresentationStyle, transitionStyle: modalTransitionStyle)
        templateVC.shouldShowCancel = true
        
        /*
        //this the way to use presentingVC's style
        self.modalPresentationStyle = .currentContext
        self.definesPresentationContext = true
        self.providesPresentationContextTransitionStyle = true
        self.modalTransitionStyle = .crossDissolve
        */
        
        self.present(templateVC, animated: true, completion: nil)
    }
    
    func customPresentStyle(for viewController: UIViewController, presentationStyle: UIModalPresentationStyle, transitionStyle: UIModalTransitionStyle = .flipHorizontal) {
        viewController.modalPresentationStyle = presentationStyle
        //invalid case: partialCurl must match fullScreen
        if (transitionStyle == .partialCurl && presentationStyle != .fullScreen){
            return
        }
        viewController.modalTransitionStyle = transitionStyle
        
        switch presentationStyle {
        case .popover:
            viewController.popoverPresentationController?.sourceView = presentButton
        case .currentContext, .overCurrentContext:
            self.definesPresentationContext = true
        default: break
        }
        
    }
}
