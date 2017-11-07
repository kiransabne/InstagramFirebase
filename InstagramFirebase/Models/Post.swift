//
//  Post.swift
//  InstagramFirebase
//
//  Created by everipedia_iMac on 11/7/17.
//  Copyright © 2017 Christian Deciga. All rights reserved.
//

import Foundation


struct Post {
    
    let imageUrl: String 
    
    //dictionary constructor
    init(dictionary: [String: Any]) {
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
    }
}








