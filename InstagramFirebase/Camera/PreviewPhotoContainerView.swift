//
//  PreviewPhotoContainerView.swift
//  InstagramFirebase
//
//  Created by everipedia_iMac on 12/11/17.
//  Copyright © 2017 Christian Deciga. All rights reserved.
//

import UIKit
import Photos

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
    
    //save button
    let saveButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "save_shadow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        return button
    }()
    
    //handle save function
    @objc func handleSave() {
        //save image to device album use libraries in photos SDK
        print("handling save...")
        
        guard let previewImage = previewImageView.image else { return }
        
        //get reference to photo library
        let library = PHPhotoLibrary.shared() //use this to save images to photo album
        
        library.performChanges({
            
            PHAssetChangeRequest.creationRequestForAsset(from: previewImage)
            
            
        }) { (success, err) in
            if let err = err {
                print("Failed to save image to photo library:", err)
                return
            }
            print("Successfully saved image to library")
        }
        
    }
    
    
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
        
        addSubview(saveButton)
        saveButton.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 24, paddingBottom: 24, paddingRight: 0, width: 50, height: 50)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
