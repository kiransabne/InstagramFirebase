//
//  CustomImageView.swift
//  InstagramFirebase
//
//  Created by everipedia_iMac on 11/7/17.
//  Copyright © 2017 Christian Deciga. All rights reserved.
//

import UIKit

class CustomImageView: UIImageView {
    
    var lastURLUsedToLoadImage: String?
    
    
    func loadImage(urlString: String) {
        print("Loading image...")
        
        lastURLUsedToLoadImage = urlString
        
        
        //load image
        guard let url = URL(string: urlString) else { return }
        
        //data task operation occurs asynchronously on background thread
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("Failed to fetch post image:", err)
                return
            }
            
            if url.absoluteString != self.lastURLUsedToLoadImage {
                return
            }
            
            //call external image with url
            guard let imageData = data else { return }
            
            let photoImage = UIImage(data: imageData)
            
            //execute on main thread
            DispatchQueue.main.async {
                //update image view in main thread
                self.image = photoImage //set image directly
                
                
            }
            
            }.resume() // use resume at end of data task operations
        
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
}
