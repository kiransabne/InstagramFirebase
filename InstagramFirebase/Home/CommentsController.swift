//
//  CommentsController.swift
//  InstagramFirebase
//
//  Created by everipedia_iMac on 12/14/17.
//  Copyright © 2017 Christian Deciga. All rights reserved.
//

import UIKit
import Firebase

class CommentsController: UICollectionViewController {
    
    var post: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Comments" //add title for nav bar
        
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
    
    //textfield for comments
    lazy var containerView: UIView = {
        
        let containerView = UIView()
        containerView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        containerView.frame = CGRect(x: 0, y: 0, width: 100, height: 50) //specify frame
        
        //submit button
        let submitButton = UIButton(type: .system)
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(.black, for: .normal)
        submitButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        submitButton.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside) //addtarget to submit button
        containerView.addSubview(submitButton)
        submitButton.anchor(top: containerView.topAnchor, left: nil, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 50, height: 0)
        
        
        containerView.addSubview(self.commentTextField)
        self.commentTextField.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: submitButton.leftAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        return containerView
        
    }()
    
    //enter user input comments
    let commentTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Comment"
        return textField
        
    }()
    
    
    //action for submit button
    @objc func handleSubmit() {
        
        print("post id:", self.post?.id ?? "")
        
        print("Inserting comment:", commentTextField.text ?? "")
        
        let postId = self.post?.id ?? ""
        let values = ["text": commentTextField.text ?? "", "creationDate": Date().timeIntervalSince1970] as [String : Any]
        
        //save user comment to Firebase, create 4th node in firebase where comments will live
        Database.database().reference().child("comments").child(postId).childByAutoId().updateChildValues(values) { (err, ref) in
            
            if let err = err {
                print("Failed to insert comment:", err)
                return
            }
            
            print("Successfully inserted comment.")
        }
        
    }
    
    //accessory view property to show bottom portion of comments page
    override var inputAccessoryView: UIView? {
        get {
            
            return containerView
        }
    }
    
    //show accessory view in controller
    override var canBecomeFirstResponder: Bool {
        return true
    }
}
