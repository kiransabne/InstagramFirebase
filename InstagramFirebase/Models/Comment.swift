//
//  Comment.swift
//  InstagramFirebase
//
//  Created by everipedia_iMac on 12/18/17.
//  Copyright © 2017 Christian Deciga. All rights reserved.
//

import Foundation

//comment model object
struct Comment {
    
    var user: User? 
    
    let text: String
    let uid: String
    
    //initializer will give snapshot value, set up properties
    init(dictionary: [String: Any]) {
        self.text = dictionary["text"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }
    
}
