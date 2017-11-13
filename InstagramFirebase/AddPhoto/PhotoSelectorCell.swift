//
//  PhotoSelectorCell.swift
//  InstagramFirebase
//
//  Created by everipedia_iMac on 11/3/17.
//  Copyright © 2017 Christian Deciga. All rights reserved.
//

import UIKit

class PhotoSelectorCell: UICollectionViewCell {
    
    //display image from assets
    let photoImageView: UIImageView = {
       let iv = UIImageView()
       iv.contentMode = .scaleAspectFill
       iv.clipsToBounds = true 
       iv.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
       return iv
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //set up photo selector cell
        
        addSubview(photoImageView)
        photoImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}

