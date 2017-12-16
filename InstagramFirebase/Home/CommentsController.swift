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
        
        
    }
    
    //when slide covers tab hidden
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //perform hiding of tab bar
        tabBarController?.tabBar.isHidden = true
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    //accessory view property to show bottom portion of comments page
    override var inputAccessoryView: UIView? {
        get {
            let containerView = UIView()
            containerView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            containerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50) //specify frame
            
            //text field, render it out inside bottom bar
            let textField = UITextField()
            textField.placeholder = "Enter Comment"
            containerView.addSubview(textField)
            textField.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
            
            return containerView
        }
    }
    
    //show accessory view in controller
    override var canBecomeFirstResponder: Bool {
        return true
    }
}
