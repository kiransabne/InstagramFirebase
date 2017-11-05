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
    
    //imageview programatically
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        iv.contentMode = .scaleAspectFill
        return iv
    
    }()
    
    
    
    fileprivate func setupImageAndTextViews() {
        //setup image and text views in this method
        
        let containerView = UIView()
        containerView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        //add containerview with constraints
        view.addSubview(containerView)
        containerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 100)
        containerView.addSubview(imageView)
        imageView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 0, width: 84, height: 0)
    }
    
    
    
    @objc func handleShare() {
        print("handle share")
    }
    
    
    
    //hide the status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
