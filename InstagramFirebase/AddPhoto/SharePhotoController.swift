//
//  SharePhotoController.swift
//  InstagramFirebase
//
//  Created by everipedia_iMac on 11/4/17.
//  Copyright © 2017 Christian Deciga. All rights reserved.
//

import UIKit
import Firebase

class SharePhotoController: UIViewController {
    
    //hold on to selected image
    var selectedImage: UIImage? {
        didSet {
            
            self.imageView.image = selectedImage
        }
    }
    
    
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
        iv.clipsToBounds = true
        return iv
    
    }()
    
    //text next to imageview
    let textView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 14)
        return tv
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
        
        //add TextView next imageview
        containerView.addSubview(textView)
        textView.anchor(top: containerView.topAnchor, left: imageView.rightAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    
    
    @objc func handleShare() {
        
        guard let image = selectedImage else { return }
        
        guard let uploadData = UIImageJPEGRepresentation(image, 0.5) else { return }
        
        //call Firebase reference to store photo to Firebase
        let filename = NSUUID().uuidString
        Storage.storage().reference().child("posts").child(filename).putData(uploadData, metadata: nil) { (metadata, err) in
            
            if let err = err {
                print("Failed to upload post image:", err)
                return
            }
            
            //upload to Firebase storage
            guard let imageUrl = metadata?.downloadURL()?.absoluteString else { return }
            
            print("Successfully uploaded post image:", imageUrl)
            self.saveToDatabaseWithImageUrl(imageUrl: imageUrl) //call to save image to Firebase database
            
            
            
        }
    }
    
    //save to Firebase database
    fileprivate func saveToDatabaseWithImageUrl(imageUrl: String) {
        
        guard let postImage = selectedImage else { return }
        
        //save caption text
        guard let caption = textView.text else { return }
        
        
        //uid is user currently logged in
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        //save to Firebase database
        let userPostRef = Database.database().reference().child("posts").child(uid)
        let ref = userPostRef.childByAutoId()
        
        //values dictionary
        let values = ["imageUrl": imageUrl, "caption": caption, "imageWidth": postImage.size.width, "imageHeight": postImage.size.height, "creationDate": Date().timeIntervalSince1970] as [String: Any]
        
        ref.updateChildValues(values) { (err, ref) in
        if let err = err {
            print("Failed to save post to DB", err)
            return
        }
            print("Successfully saved post to DB")
        }
    }
    
    //hide the status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
