//
//  HomePostCell.swift
//  InstagramFirebase
//
//  Created by everipedia_iMac on 11/10/17.
//  Copyright © 2017 Christian Deciga. All rights reserved.
//

import UIKit

//new cell renders out entire post

class HomePostCell: UICollectionViewCell {
    
    //var to render image to cell
    var post: Post? {
        didSet {
            
            guard let postImageUrl = post?.imageUrl else { return } //Url to load image into cell
            
           
            photoImageView.loadImage(urlString: postImageUrl)
        }
    }
    
    
    //userprofile image
    let userProfileImageView: CustomImageView = {
        
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        return iv
        
        
    }()
    
    
    //create image view to load into cell using customimageview
    let photoImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
       
        return iv
        
    }()
    
    //cells
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(userProfileImageView) //add userprofileImageView
        userProfileImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        userProfileImageView.layer.cornerRadius = 40 / 2 //make round
        
        addSubview(photoImageView) //add image to the cell
        photoImageView.anchor(top: userProfileImageView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
