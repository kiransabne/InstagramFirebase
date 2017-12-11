//
//  PreviewPhotoContainerView.swift
//  InstagramFirebase
//
//  Created by everipedia_iMac on 12/11/17.
//  Copyright © 2017 Christian Deciga. All rights reserved.
//

import UIKit

//customize container view for camera after taking photo
class PreviewPhotoContainerView: UIView {
    
    //show preview image
    let previewImageView: UIImageView = {
        let iv = UIImageView()
        return iv
        
        
    }()
    
    //cancel button in container view
    let cancelButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "cancel_shadow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
        
    }()
    
    //handle cancel function
    @objc func handleCancel() {
        self.removeFromSuperview()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        
        addSubview(previewImageView)
        previewImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        addSubview(cancelButton)
        cancelButton.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
