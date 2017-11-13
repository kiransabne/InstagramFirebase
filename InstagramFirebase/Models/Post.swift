//
//  Post.swift
//  InstagramFirebase
//
//  Created by everipedia_iMac on 11/7/17.
//  Copyright © 2017 Christian Deciga. All rights reserved.
//

import Foundation

//Post Object

struct Post {
    
    let user: User
    let imageUrl: String
    let caption: String //caption property
    
    //dictionary constructor
    init(user: User, dictionary: [String: Any]) {
        self.user = user 
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        self.caption = dictionary["caption"] as? String ?? ""
    }
}








