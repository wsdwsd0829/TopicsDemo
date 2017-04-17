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
class CustomPresentAnimateViewController: UIViewController, UIViewControllerTransitioningDelegate {
    var panGesture: UIPanGestureRecognizer!
    var shouldInteractive = true
    
    var interactiveObject: InteractiveObject!
    func getInteractiveObject() -> InteractiveObject {
        let interactiveObj = InteractiveObject()
        interactiveObj.presentFromVC = self
        return interactiveObj
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactiveObject = getInteractiveObject()
        panGesture = UIPanGestureRecognizer(target: interactiveObject, action: #selector(interactiveObject.swipeUpdate(_:)))
        view.addGestureRecognizer(panGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.panGesture.maximumNumberOfTouches = 1
    }
    
    @IBAction func animatedClicekd(_ sender: UIButton) {
        let avc = AnimatedViewController(nibName: "AnimatedViewController", bundle: nil)
        avc.transitioningDelegate = self
        //TODO: cause crash
        //avc.modalPresentationStyle = .custom
        shouldInteractive = false
        present(avc, animated: true, completion: {
            self.shouldInteractive = true
        })
    }

    //Custom Animation
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let ao = AnimatorObject()
        ao.presenting = false
        return ao
    }
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimatorObject()
    }
    //Interactive Transition
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if shouldInteractive {
            return interactiveObject
        } else {
            return nil
        }
    }
    
    //TODO: not working see AnimatedViewController
    /*
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if shouldInteractive {
            interactiveObject.presenting = false
            return interactiveObject
        } else {
            return nil
        }
    }
     */
}
