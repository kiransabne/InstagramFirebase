//
//  UserSearchCell.swift
//  InstagramFirebase
//
//  Created by everipedia_iMac on 11/16/17.
//  Copyright © 2017 Christian Deciga. All rights reserved.
//

import UIKit

//custom search cell

class UserSearchCell: UICollectionViewCell {
    
    //user object
    var user: User? {
        didSet {
            usernameLabel.text = user?.username //set text to the username
        }
    }
    
    
    //profile image view, load image view using URL string
    let profileImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
        
        
    }()
    
    //username label
    let usernameLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Username"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        addSubview(profileImageView)
        addSubview(usernameLabel)
        
        //profileImageView
        profileImageView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
        profileImageView.layer.cornerRadius = 50 / 2 //round image view
        profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true //center on Y axis
        
        //usernameLabel
        usernameLabel.anchor(top: topAnchor, left: profileImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        //seperator view between search results
        let seperatorView = UIView()
        seperatorView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        addSubview(seperatorView)
        seperatorView.anchor(top: nil, left: usernameLabel.leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}






