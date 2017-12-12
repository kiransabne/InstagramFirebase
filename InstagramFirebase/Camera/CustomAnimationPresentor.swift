//
//  CustomAnimationPresentor.swift
//  InstagramFirebase
//
//  Created by everipedia_iMac on 12/12/17.
//  Copyright © 2017 Christian Deciga. All rights reserved.
//

import UIKit

//custom animation for Camera
class CustomAnimationPresentor: NSObject, UIViewControllerAnimatedTransitioning {
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //custom animation transiton code logic
        
        let containerView = transitionContext.containerView //reference call
        guard let toView = transitionContext.view(forKey: .to) else { return }
        
        
        containerView.addSubview(toView)
        
        
        let startingFrame = CGRect(x: 300, y: 0, width: toView.frame.width, height: toView.frame.height)
        toView.frame = startingFrame
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            //animation?/
            
            toView.frame = CGRect(x: 0, y: 0, width: toView.frame.width, height: toView.frame.height)
            
            
        }) { (_) in
            
            transitionContext.completeTransition(true)
            
        }
    }

}

