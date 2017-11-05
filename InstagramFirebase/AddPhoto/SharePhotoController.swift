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
        
        view.backgroundColor = #colorLiteral(red: 0.9567589164, green: 0.9569225907, blue: 0.9567485452, alpha: 1)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(handleShare)) //create Share bar button item
        
        setupImageAndTextViews()
    }
    
    fileprivate func setupImageAndTextViews() {
        //setup image and text views in this method
        
        let containerView = UIView()
        containerView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        //add containerview with constraints
        view.addSubview(containerView)
        containerView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 100)
    }
    
    
    
    @objc func handleShare() {
        print("handle share")
    }
    
    
    
    //hide the status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
