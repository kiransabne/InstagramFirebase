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
        
        //collectionview
        let layout = UICollectionViewFlowLayout()
        let userProfileController = UserProfileController(collectionViewLayout: layout)
        
        //programmatically build navigation controller
        let navController = UINavigationController(rootViewController: userProfileController)
        
        viewControllers = [navController]
    }
    
    
}

