//
//  HomeController.swift
//  InstagramFirebase
//
//  Created by everipedia_iMac on 11/9/17.
//  Copyright © 2017 Christian Deciga. All rights reserved.
//

import UIKit
import Firebase

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        
        collectionView?.register(HomePostCell.self, forCellWithReuseIdentifier: cellId)
        
        setupNavigationItems() //call navbar
        fetchPosts()
    }
    
    var posts = [Post]() //array of posts
    
    //access to user's posts
    fileprivate func fetchPosts() {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        //completion call to fetch post from extension
        Database.fetchUserWithUID(uid: uid) { (user) in
            self.fetchPostsWithUser(user: user)
        }
        
    }
    
    
    //user object 
    fileprivate func fetchPostsWithUser(user: User) {
        
        //fetch post belonging to the right user
        let ref = Database.database().reference().child("posts").child(user.uid);ref.observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let dictionaries = snapshot.value as? [String: Any] else { return }
            
            dictionaries.forEach({ (key, value) in
                guard let dictionary = value as? [String: Any] else { return }
                
                let post = Post(user: user, dictionary: dictionary)
                
                self.posts.append(post)
            })
            
            self.collectionView?.reloadData()
            
        }) { (err) in
            print("Failed to fetch posts:", err)
        
        }
    }
    
    
    //set up navbar
    func setupNavigationItems() {
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "logo2"))
    }
    
    
    //render customize size instead of default 50x50
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 40 + 8 + 8 //username userprofileImageView
        height += view.frame.width
        height += 50
        height += 60 //size of label caption
        
        
        return CGSize(width: view.frame.width, height: height)
    }
    
    //render out items in collection view
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //get cell from collectionview by dequeue
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomePostCell
        
        cell.post = posts[indexPath.item] //render home posts
        
         return cell
       
        
        
    }
    
}

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














