//
//  CustomImageView.swift
//  InstagramFirebase
//
//  Created by everipedia_iMac on 11/7/17.
//  Copyright © 2017 Christian Deciga. All rights reserved.
//

import UIKit

var imageCache = [String: UIImage]() //var to help user not use up a lot of data

class CustomImageView: UIImageView {
    
    var lastURLUsedToLoadImage: String?
    
    //fetch images
    func loadImage(urlString: String) {
        print("Loading image...")
        
        lastURLUsedToLoadImage = urlString
        
        //check cache for the image
        if let cacheImage = imageCache[urlString] {
            
           self.image = cacheImage
            return
            
        }
        
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
            
            imageCache[url.absoluteString] = photoImage //stuff image into cache
            
            //execute on main thread
            DispatchQueue.main.async {
                //update image view in main thread
                self.image = photoImage //set image directly
                
                
            }
            
            }.resume() // use resume at end of data task operations
        
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
}
