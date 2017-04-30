//
//  AnimatorObject.swift
//  TopicDemos
//
//  Created by Sida Wang on 4/16/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

import UIKit

class AnimatorObject: NSObject, UIViewControllerAnimatedTransitioning {
    var presenting = true
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let fromVC = transitionContext.viewController(forKey: .from) else {
            fatalError("no presentation")
        }
        
        guard let toVC = transitionContext.viewController(forKey: .to) else {
            fatalError("no presentation")
        }
        guard let fromView = transitionContext.view(forKey: .from) else {
            fatalError("no presentation")
        }
        
        guard let toView = transitionContext.view(forKey: .to) else {
            fatalError("to view should be there")
        }
        let containerFrame = containerView.frame
        
        var initialToFrame = transitionContext.initialFrame(for: toVC) //to change and animate for presenting
        let finalToFrame = transitionContext.finalFrame(for: toVC) //to assign after presenting
        var finalFromFrame = transitionContext.finalFrame(for: fromVC) //to change for dismissing
       
        if presenting { //present
            initialToFrame.origin.x = toView.bounds.size.width
            initialToFrame.origin.y = toView.bounds.size.height
            toView.frame = initialToFrame
            containerView.addSubview(toView)
        }

        if !presenting {
            finalFromFrame.origin.x += fromView.frame.size.width
            finalFromFrame.origin.y -= fromView.frame.size.height
            toView.frame = containerFrame
            containerView.insertSubview(toView, at: 0) //Document error !!!
        }

        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
            if self.presenting {
                toView.frame = finalToFrame
            } else {
                fromView.frame = finalFromFrame
            }
        }) { completed in
            let success = !transitionContext.transitionWasCancelled
            if (!self.presenting && success) || (self.presenting && !success) {
                fromView.removeFromSuperview()
            }
            transitionContext.completeTransition(completed)
        }
    }
}
