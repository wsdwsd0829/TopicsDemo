//
//  InteractiveObject.swift
//  TopicDemos
//
//  Created by Sida Wang on 4/16/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

import UIKit

class InteractiveObject: UIPercentDrivenInteractiveTransition {
    var transitionContext: UIViewControllerContextTransitioning!
    var presenting = true
    lazy var avc = AnimatedViewController(nibName: "AnimatedViewController", bundle: nil)
    
    var presentFromVC: CustomPresentAnimateViewController!
    
    override func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        super.startInteractiveTransition(transitionContext)
        self.transitionContext = transitionContext
       // finish()
    }
    
    func swipeUpdate(_ sender: UIPanGestureRecognizer) {
        guard let container = presentFromVC.view else {
            return
        }
        if sender.state == .began {
            sender.setTranslation(CGPoint.zero, in: container)
            avc.transitioningDelegate = presentFromVC
            if presenting {
                presentFromVC.present(avc, animated: true, completion: nil)
            } else {
                presentFromVC.dismiss(animated: true, completion: {
                    self.presenting = true
                }) 
            }
        } else if sender.state == .changed {
            let point = sender.translation(in: container)
            print(point)
            let percentage = fabs(point.y / container.bounds.height)
            update(percentage)
        } else if sender.state == .ended {
            finish()
        }
    }
    /*
 //TODO: fix document: did not get what it means
 func swipeUpdate(_ sender: UIPanGestureRecognizer) {
 let container = transitionContext.containerView
 if sender.state == .began {
 panGesture.setTranslation(CGPoint.zero, in: container)
 let avc = AnimatedViewController(nibName: "AnimatedViewController", bundle: nil)
 avc.transitioningDelegate = presentFromVC
 presentFromVC.present(avc, animated: true, completion: nil)
 
 } else if sender.state == .changed {
 let point = panGesture.translation(in: container)
 print(point)
 let percentage = fabs(point.y / container.bounds.height)
 update(percentage)
 } else if sender.state == .ended {
 finish()
 container.removeGestureRecognizer(panGesture)
 }
 }
 */
}
