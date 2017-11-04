//
//  PhotoSelectorHeader.swift
//  InstagramFirebase
//
//  Created by everipedia_iMac on 11/4/17.
//  Copyright © 2017 Christian Deciga. All rights reserved.
//

import UIKit

class PhotoSelectorHeader: UICollectionViewCell {
    
    //code for header view cell
    
    let photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
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
