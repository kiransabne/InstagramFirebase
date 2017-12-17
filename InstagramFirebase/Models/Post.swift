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
    
    var id: String? 
    
    let user: User
    let imageUrl: String
    let caption: String //caption property
    let creationDate: Date //creation date property
    
    //dictionary constructor
    init(user: User, dictionary: [String: Any]) {
        self.user = user 
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        self.caption = dictionary["caption"] as? String ?? ""
        
        //creation date object property
        let secondsFrom1970 = dictionary["creationDate"] as? Double ?? 0
        self.creationDate = Date(timeIntervalSince1970: secondsFrom1970)
    }
}





