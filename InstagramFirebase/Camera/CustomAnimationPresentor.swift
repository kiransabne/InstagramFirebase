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
        return 05
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //custom animation transiton code logic
    }
}

