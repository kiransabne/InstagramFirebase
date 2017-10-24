//
//  UserProfileHeader.swift
//  InstagramFirebase
//
//  Created by everipedia_iMac on 10/23/17.
//  Copyright © 2017 Christian Deciga. All rights reserved.
//

import UIKit
import Firebase

class UserProfileHeader: UICollectionViewCell {
    
    //adding userprofile view programmatically
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        return iv
    }() //execute the closure
    
    
    
    //UIView objects subclass
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        //add to cell hierarchy with constraints
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 80, height: 80)
        
        //make block rounded view
        profileImageView.layer.cornerRadius = 80 / 2 //width value by 2
        profileImageView.clipsToBounds = true
        
        setupProfileImage() //method call
    }
    
    
    fileprivate func setupProfileImage() {
        
        //fetch username for Firebase users using guard let statement
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot.value ?? "")
            
            //access snapshot
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            
            guard let profileImageUrl = dictionary["profileImageUrl"] as? String else  { return }
            
            guard let url = URL(string: profileImageUrl) else { return }
            
            //datatask completion block handler
            URLSession.shared.dataTask(with: url) { (data, response, err)
                in
                //check the error, then construct the image using data
                if let err = err {
                    print("Failed to fetch profile image:", err)
                    return
                }
                
                //perhaps check for response status of 200 (HTTP OK)
                
                //handle image
                guard let data = data else { return }
                
                let image = UIImage(data: data)
                
                //get back on main thread, need to get back on main UI thread to prevent crash
                DispatchQueue.main.async {
                    self.profileImageView.image = image
                }
    
                
                
                }.resume()
            
                }) { (err) in
                print("Failed to fetch user:", err)
           
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
