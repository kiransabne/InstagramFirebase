//
//  User.swift
//  InstagramFirebase
//
//  Created by everipedia_iMac on 11/14/17.
//  Copyright © 2017 Christian Deciga. All rights reserved.
//

import Foundation
//User class

//model object using struct
struct User {
    
    let uid: String
    let username: String
    let profileImageUrl: String
    
    //constructor to help set up properties
    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid 
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
    }
    
}
