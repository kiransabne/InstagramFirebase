//
//  UserProfilePhotoCell.swift
//  InstagramFirebase
//
//  Created by everipedia_iMac on 11/7/17.
//  Copyright © 2017 Christian Deciga. All rights reserved.
//

import UIKit


class UserProfilePhotoCell: UICollectionViewCell {
    
    //image view to load image in
    let photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
        
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
