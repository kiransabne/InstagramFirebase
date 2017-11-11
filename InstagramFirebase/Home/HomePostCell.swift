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
    
    //create image view
    let photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        return iv
        
    }()
    
    //cells
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(photoImageView) //add image to the cell
        photoImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
