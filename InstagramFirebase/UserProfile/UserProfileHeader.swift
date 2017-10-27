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
    
    
    //create grid button programmatically
    let gridButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "grid"), for: .normal)
        return button
        
    }()
    
    //grid list button
    let listButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "list"), for: .normal)
        return button
    }()
    
    //bookmark button
    let bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "ribbon"), for: .normal)
        return button
    }()
    
    
    
    
    //UIView objects subclass
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //add to cell hierarchy with constraints
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 80, height: 80)
        
        //make block rounded view
        profileImageView.layer.cornerRadius = 80 / 2 //width value by 2
        profileImageView.clipsToBounds = true
        
        setupBottomToolbar()
    }
    
    //func for toolbar
    fileprivate func setupBottomToolbar() {
        let stackView = UIStackView(arrangedSubviews: [gridButton, listButton, bookmarkButton]) //stackview
        
        addSubview(stackView)
        
        //anchor to bottom of the header set constraints
        stackView.anchor(top: nil, left: leftAnchor, bottom: self.bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
    }
    
    
    
    //model object
    var user: User? {
        didSet {
            setupProfileImage()
            
        }
    }
    
    
    
    fileprivate func setupProfileImage() {
        
        //fetch username for Firebase users using guard let statement
        guard let profileImageUrl = user?.profileImageUrl else { return }
        
        guard let url = URL(string: profileImageUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            //check for the error, then construct the image using data
            if let err = err {
                print("Failed to fetch profile image:", err)
                return
            }
            
            //perhaps check for response status of 200 (HTTP OK)
            guard let data = data else { return }
            
            let image = UIImage(data: data)
           //need to get back onto the main UI thread
            DispatchQueue.main.async {
                self.profileImageView.image = image
            }
            
        }.resume()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
