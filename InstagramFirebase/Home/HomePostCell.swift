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
            
            usernameLabel.text = "TEST USERNAME" //displays username
            
            usernameLabel.text = post?.user.username //wouldn't this be nice? have to set up data models in project so that they contain reference to whatever we need
            
            
            guard let profileImageUrl = post?.user.profileImageUrl else { return } //display userprofileimage view inside post object
            
            userProfileImageView.loadImage(urlString: profileImageUrl) //dispaly userprofileimage view inside post object
            
            captionLabel.text = post?.caption //show caption from user
            
        }
    }
    
    
    //userprofile image
    let userProfileImageView: CustomImageView = {
        
        let iv = CustomImageView()
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
    
    
    //options button
    let optionsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("•••", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
     
    }()
    
    //like button
    let likeButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "like_unselected").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    
    //comment button
    let commentButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "comment").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
        
    }()
    
    //send button
    let sendMessageButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "send2").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    
    
    //create image view to load into cell using customimageview
    let photoImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
       
        return iv
        
    }()
    
    //bookmark button
    let bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "ribbon").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    
    //caption label text
    let captionLabel: UILabel = {
        let label = UILabel()
        
        //render out attributed text
        let attributedText = NSMutableAttributedString(string: "Username", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize:14)])
        
        attributedText.append(NSAttributedString(string: " Some caption text that will perhaps wrap onto the next line", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]))
        
        attributedText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 4)])) //small gap in between label
        
        
        attributedText.append(NSAttributedString(string: "1 week ago", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.gray]))
        
        label.attributedText = attributedText
        label.numberOfLines = 0 //wrap the text
        
    
        return label
    }()
    
    
    //Initializer cells
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(userProfileImageView) //add userprofileImageView
        addSubview(usernameLabel) //add usernameLabel to view
        addSubview(photoImageView) //add image to the cell
        addSubview(optionsButton)
        
        //anchors (constraints)
        userProfileImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        userProfileImageView.layer.cornerRadius = 40 / 2 //make round
        
        usernameLabel.anchor(top: topAnchor, left: userProfileImageView.rightAnchor, bottom: photoImageView.topAnchor, right: optionsButton.leftAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        optionsButton.anchor(top: topAnchor, left: nil, bottom: photoImageView.topAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 44, height: 44)
        
        photoImageView.anchor(top: userProfileImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        photoImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true //adds space between posts
        
        
        setupActionButtons() //call function for action buttons
        addSubview(captionLabel)
        captionLabel.anchor(top: likeButton.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
    }
    
    //place three buttons into view using a stackview
    fileprivate func setupActionButtons() {
        
        //stackview
        let stackView = UIStackView(arrangedSubviews: [likeButton, commentButton, sendMessageButton])
        
        stackView.distribution = .fillEqually
        addSubview(stackView) //add to view
        stackView.anchor(top: photoImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: 120, height: 50)
        
        addSubview(bookmarkButton) //add bookmarkbutton
        bookmarkButton.anchor(top: photoImageView.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 40, height: 50)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
