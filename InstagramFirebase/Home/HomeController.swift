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
        
        //set up Observer for catching notification from SharePhotoController.swift
        NotificationCenter.default.addObserver(self, selector: #selector(handleUpdateFeed), name: SharePhotoController.updateFeedNotificationName, object: nil)
    
        
        collectionView?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        collectionView?.register(HomePostCell.self, forCellWithReuseIdentifier: cellId)
        
        //pull down to refresh
        let refreshControl = UIRefreshControl() //
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView?.refreshControl = refreshControl
        
        
        setupNavigationItems() //call navbar
        fetchAllPosts() //refactored
    
}
    
    //method to handle update feed automatically after saving to Firebase
    @objc func handleUpdateFeed() {
        handleRefresh() //call handlerRefresh
    }
    
    
    //method for pull down to refresh
    @objc func handleRefresh() {
        //need to fetch posts from following users
        print("Handling refresh...")
        
        posts.removeAll() //fixes bug when unfollowing a person, doesn't show their posts
        
        fetchAllPosts()
        
    }
    
    //refactored for refresh control
    fileprivate func fetchAllPosts() {
        fetchPosts()
        fetchFollowingUserIds()
    }
    
    //fetch posts from users you are following
    fileprivate func fetchFollowingUserIds() {
        
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Database.database().reference().child("following").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            
            guard let userIdsDictionary = snapshot.value as? [String: Any] else { return }
            
            userIdsDictionary.forEach({ (key, value) in
                Database.fetchUserWithUID(uid: key, completion: { (user) in
                    
                    self.fetchPostsWithUser(user: user)
                })
                
            })
            
            
            
        }) { (err) in
            print("Failed to fetch following user ids:", err)
        }
        
        
    }
    
    //iOS 9 create instance if want to use stop refresh control
    //let refreshControl = UIRefreshControl()
    
    
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
            
            self.collectionView?.refreshControl?.endRefreshing() //stop spinner after refreshing
            
            guard let dictionaries = snapshot.value as? [String: Any] else { return }
            
            dictionaries.forEach({ (key, value) in
                guard let dictionary = value as? [String: Any] else { return }
                
                let post = Post(user: user, dictionary: dictionary)
                
                self.posts.append(post)
            })
            
            //sort post array in place, everytime get a post back from dictionary, sort it
            self.posts.sort(by: { (p1, p2) -> Bool in
                
                return p1.creationDate.compare(p2.creationDate) == .orderedDescending
            })
            
            self.collectionView?.reloadData()
            
        }) { (err) in
            print("Failed to fetch posts:", err)
        
        }
    }
    
    
    //set up navbar
    func setupNavigationItems() {
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "logo2"))
        
        //bar button item on top left Camera Icon
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "camera3").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleCamera))
        
    }
    
    
    @objc func handleCamera() {
        print("Showing camera")
        
        //view controller to present created in CameraController.swift
        let cameraController = CameraController()
        
        
        //present controller for camera
        present(cameraController, animated: true, completion: nil)
        
        
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

