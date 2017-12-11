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
            
            //use DispatchQueue to prevent showing label slowing down , shows faster
            DispatchQueue.main.async {
                
                //create animation label using frame much easier using frames after successfully saving image to library
                let savedLabel = UILabel()
                savedLabel.text = "Saved Successfully"
                savedLabel.font = UIFont.boldSystemFont(ofSize: 18)
                savedLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                savedLabel.numberOfLines = 0
                savedLabel.backgroundColor = UIColor(white: 0, alpha: 0.3)
                savedLabel.textAlignment = .center
                savedLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 80) //use frame to animate label
                savedLabel.center = self.center
                self.addSubview(savedLabel) //add label to entire container
                
                
                savedLabel.layer.transform = CATransform3DMakeScale(0, 0, 0)
                
                //apply animation to savedLabel
               
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                    
                    //animation
                    savedLabel.layer.transform = CATransform3DMakeScale(1, 1, 1)
                    
                }, completion: { (completion) in
                    //completed
                    //execute another animation inside completion
                    
                    UIView.animate(withDuration: 0.5, delay: 0.75, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                        
                         savedLabel.layer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1)
                         savedLabel.alpha = 0 //fade away animation
                        
                    }, completion: { (_) in
                        
                        savedLabel.removeFromSuperview()
                       
                    })
                    
                })
            }
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
