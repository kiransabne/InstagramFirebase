//
//  UserProfileController.swift
//  InstagramFirebase
//
//  Created by everipedia_iMac on 10/22/17.
//  Copyright © 2017 Christian Deciga. All rights reserved.
//

import UIKit
import Firebase

class UserProfileController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        //show user profile using Firebase
        navigationItem.title = Auth.auth().currentUser?.uid
        
        //call user name instead of Firebase id characters
        fetchUser()
        
        //register collectionview with a header
        collectionView?.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerId")
        
    }
    
    //
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        //specify header
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath)
       
        
        
        return header
        
    }
    
    //specify header in header method
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        
        return CGSize(width: view.frame.width, height: 200) //header with height and width
    }
    
    var user: User?
    
    //set user name instead of Firebase id characters using fileprivate(can only access this func within this class
    fileprivate func fetchUser() {
        //fetch username for Firebase users using guard let statement
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        
        //completion block
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot.value ?? "")
            
            
            //access snapshot
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            
            //let profileImageUrl = dictionary["profileImageUrl"] as? String
            //let username = dictionary["username"] as? String
            
            
            self.user = User(dictionary: dictionary) //constructed object from var user: User?
            
            self.navigationItem.title = self.user?.username //set title of username
            
            self.collectionView?.reloadData()
            
        }) { (err) in
            print("Failed to fetch user:", err)
            
            
        }
    }
    
}

//model object using struct
struct User {
    let username: String
    let profileImageUrl: String
    
    //constructor to help set up properties
    init(dictionary: [String: Any]) {
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
    }
    
}






