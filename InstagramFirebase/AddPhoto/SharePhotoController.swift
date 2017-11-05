//
//  SharePhotoController.swift
//  InstagramFirebase
//
//  Created by everipedia_iMac on 11/4/17.
//  Copyright © 2017 Christian Deciga. All rights reserved.
//

import UIKit


class SharePhotoController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(handleShare)) //create Share bar button item
    }
    
    @objc func handleShare() {
        print("handle share")
    }
    
    
    
    //hide the status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
