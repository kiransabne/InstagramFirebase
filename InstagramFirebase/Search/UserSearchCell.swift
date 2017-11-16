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
    
    //profile image view, load image view using URL string
    let profileImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
        
        
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        
        addSubview(profileImageView)
        profileImageView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
        profileImageView.layer.cornerRadius = 50 / 2 //round image view
        profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true //center on Y axis
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
