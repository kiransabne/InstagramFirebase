//
//  CommentsController.swift
//  InstagramFirebase
//
//  Created by everipedia_iMac on 12/14/17.
//  Copyright © 2017 Christian Deciga. All rights reserved.
//

import UIKit

class CommentsController: UICollectionViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //collectionviewcontroller
        collectionView?.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false 
    }
    
}
