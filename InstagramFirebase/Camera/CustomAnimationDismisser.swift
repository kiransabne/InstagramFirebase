//
//  CustomAnimationDismisser.swift
//  InstagramFirebase
//
//  Created by everipedia_iMac on 12/12/17.
//  Copyright © 2017 Christian Deciga. All rights reserved.
//

import UIKit

class CustomAnimationDismisser: NSObject, UIViewControllerAnimatedTransitioning {
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //custom animation transiton code logic
        
        let containerView = transitionContext.containerView
        
        guard let fromView = transitionContext.view(forKey:.from) else { return }
        
        guard let toView = transitionContext.view(forKey: .to) else { return }
        
        //reference to container
        containerView.addSubview(toView)
        
        UIView.animate(withDuration: 0, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            //write animations here
            
            fromView.frame = CGRect(x: -fromView.frame.width, y: 0, width: fromView.frame.width, height: fromView.frame.height)
            
            toView.frame = CGRect(x: 0, y: 0, width: toView.frame.width, height: toView.frame.height)
            
        }) { (_) in
            
            transitionContext.completeTransition(true)
            
        }
    }
    
    
}
