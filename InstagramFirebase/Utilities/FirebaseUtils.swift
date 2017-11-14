//
//  FirebaseUtils.swift
//  InstagramFirebase
//
//  Created by everipedia_iMac on 11/14/17.
//  Copyright © 2017 Christian Deciga. All rights reserved.
//

import Foundation
import Firebase 

//extension method to refactor fetch user code
extension Database {
    
    //completion block used in production application shared in entire application
    static func fetchUserWithUID(uid: String, completion: @escaping (User) -> ()) {
        
        //*LOGIC
        
        //fetch user via Firebase database call to show username
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            //convert snapshot into dictionary
            guard let userDictionary = snapshot.value as? [String: Any] else { return }
            
            //turn into user
            let user = User(uid: uid, dictionary: userDictionary)  //user object, fetch the correct user
            
            
            completion(user)
            
            
        }) { (err) in
            print("Failed to fetch user for posts:", err)
        }
    }
    
}
