//
//  UserProfilePhotoCell.swift
//  InstagramFirebase
//
//  Created by everipedia_iMac on 11/7/17.
//  Copyright © 2017 Christian Deciga. All rights reserved.
//

import UIKit


class UserProfilePhotoCell: UICollectionViewCell {
    
    var post: Post? {
        
        didSet {
            print(post?.imageUrl ?? "")
            
            guard let imageUrl = post?.imageUrl else { return }
            
            guard let url = URL(string: imageUrl) else { return }
            
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                if let err = err {
                    print("Failed to fetch post image:", err)
                    return
                }
                
                //call external image with url
                guard let imageData = data else { return }
                
                let photoImage = UIImage(data: imageData)
                
                //execute on main thread
                DispatchQueue.main.async {
                    //update image view in main thread
                    self.photoImageView.image = photoImage
                    
                    
                }
                
            }.resume() // use resume at end of data task operations
        }
    }
    
    
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
        
        addSubview(photoImageView)
        photoImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been imrplemented")
    }
}
