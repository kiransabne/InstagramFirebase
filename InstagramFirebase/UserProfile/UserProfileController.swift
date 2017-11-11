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
    
    //cell id for collection view cells
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        //show user profile using Firebase
        navigationItem.title = Auth.auth().currentUser?.uid
        
        //call user name instead of Firebase id characters
        fetchUser()
        
        //register collectionview with a header
        collectionView?.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerId")
        
        //register identifier
        collectionView?.register(UserProfilePhotoCell.self, forCellWithReuseIdentifier: cellId)
        
        //gear icon to log out
        setupLogOutButton()
        
        //fetchPosts()
        fetchOrderedPosts()
        
    }
    
    var posts = [Post]()
    
    fileprivate func fetchOrderedPosts() {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        //observe child added
        let ref = Database.database().reference().child("posts").child(uid)
        
        ref.queryOrdered(byChild: "creationDate").observe(.childAdded, with: { (snapshot) in
            
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            
            let post = Post(dictionary: dictionary)
            self.posts.append(post)
            
            self.collectionView?.reloadData() //reload the posts
            
            
        }) { (err) in
            print("Failed to fetch ordered posts:", err)
        }
        
    }
    
    
    //func to sign out
    fileprivate func setupLogOutButton() {
        
        //bar button item
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "gear").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleLogOut))
        
        
    }
    
    //action when user presses logout
    @objc func handleLogOut() {
        //alert controller
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        //add actions to alert controller Log out
        alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_ ) in
           //use firebase to log out user
            
            do {
                //wrap potential sign out error in do catch block
                try Auth.auth().signOut()
                //what happens when user signs out? need to present some kind of login controllerr
                //present the logincontroller
                let loginController = LoginController()
                let navController = UINavigationController(rootViewController: loginController)
                
                self.present(navController, animated: true, completion: nil)
                
            } catch let signOutErr {
                print("Failed to sign out:", signOutErr)
            }
            
        }))
        
        //cancel alert controller
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        //present the alert controller
        present(alertController, animated: true, completion: nil)
        
        
    }
    
    //fill collectionview with cells
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return posts.count
    }
    
    //show cells
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! UserProfilePhotoCell
        
        cell.post = posts[indexPath.item] //access userprofile cell
        
        return cell
    }
    
    //minimum line spaceing horizontal
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 1
    }
    
    
    //minimum line spacing vertical
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 1
    }
    
    //size of cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (view.frame.width - 2) / 3
        return CGSize(width: width, height: width)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        //specify header UICollectionReusableCell
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as! UserProfileHeader
        
        //call var user: User?
        header.user = self.user
        
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






