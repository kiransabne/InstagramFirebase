//
//  MainTabBarController.swift
//  InstagramFirebase
//
//  Created by everipedia_iMac on 10/22/17.
//  Copyright © 2017 Christian Deciga. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //check to see if user is logged in to automatically present login controller
        if Auth.auth().currentUser == nil {
            //show in hierarchy
            DispatchQueue.main.async {
                //if user is not logged in, then present login controller
                let loginController = LoginController()
                let navController = UINavigationController(rootViewController: loginController)
                self.present(navController, animated: true, completion: nil)
            }
            
            
            return
        }
        
        setupViewControllers()
        
    }
    
    func setupViewControllers() {
        //home icon
        let homeController = UIViewController()
        let homeNavController = UINavigationController(rootViewController: homeController)
        homeNavController.tabBarItem.image = #imageLiteral(resourceName: "home_selected")
        homeNavController.tabBarItem.selectedImage = #imageLiteral(resourceName: "home_selected")
        
        
        
        //collectionview
        //user profile
        let layout = UICollectionViewFlowLayout()
        let userProfileController = UserProfileController(collectionViewLayout: layout)
        
        //programmatically build navigation controller
        let userProfileNavController = UINavigationController(rootViewController: userProfileController)
        
        //set bar tab items programmatically
        userProfileNavController.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
        userProfileNavController.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")
        
        tabBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        viewControllers = [homeNavController, userProfileNavController]
        
       // viewControllers = [navController, UIViewController()]
        
    }
    
    
}










