//
//  OpenDiaryAnimation.swift
//  superman
//
//  Created by D_ttang on 15/7/9.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class OpenAnimation: NSObject, UIViewControllerTransitioningDelegate {
    
    let openTransition = OpenTransition()
    var tmpOriginFrame: CGRect!
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        openTransition.originFrame = tmpOriginFrame
        openTransition.presenting = true
        return openTransition
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        openTransition.presenting = false
        return openTransition
    }
}

class OpenTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration    = 0.25
    var presenting  = true
    var originFrame = CGRect.zero
    
    var topImageHeight:CGFloat = 0.0
    var dismissCompletion: (()->())?
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView()
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        let herbView = presenting ? toView : transitionContext.viewForKey(UITransitionContextFromViewKey)!
        
        let initialFrame = presenting ? originFrame : herbView.frame
        let finalFrame = presenting ? herbView.frame : originFrame
        
        let yScaleFactor = presenting ? initialFrame.height / finalFrame.height : finalFrame.height / initialFrame.height
        
        let scaleTransform = CGAffineTransformMakeScale(1, yScaleFactor)

        
        if presenting {
            herbView.alpha = 0.1
            herbView.transform = scaleTransform
            herbView.center = CGPoint(
                x: CGRectGetMidX(initialFrame),
                y: CGRectGetMidY(initialFrame))
            herbView.clipsToBounds = true
        }
        
        containerView!.addSubview(toView)
        containerView!.bringSubviewToFront(herbView)
        
        UIView.animateWithDuration(duration,

            animations: {
                herbView.transform = self.presenting ? CGAffineTransformIdentity : scaleTransform
                herbView.center = CGPoint(x: CGRectGetMidX(finalFrame), y: CGRectGetMidY(finalFrame))
                herbView.alpha = self.presenting ? 1.0 : 0.0
            }, completion:{_ in
                
                if !self.presenting {
                    self.dismissCompletion?()
                }
                transitionContext.completeTransition(true)
        })
    }
}