//
//  MainTabBarController.swift
//  InstagramFirebase
//
//  Created by everipedia_iMac on 10/22/17.
//  Copyright © 2017 Christian Deciga. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let redVC = UIViewController()
        redVC.view.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        
        //programmatically build navigation controller
        let navController = UINavigationController(rootViewController: redVC)
        
        viewControllers = [navController]
    }
    
    
}

