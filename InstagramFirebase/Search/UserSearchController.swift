//
//  UserSearchController.swift
//  InstagramFirebase
//
//  Created by everipedia_iMac on 11/14/17.
//  Copyright © 2017 Christian Deciga. All rights reserved.
//

import UIKit
import Firebase

class UserSearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    //create search bar
    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Enter username"
        sb.barTintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = #colorLiteral(red: 0.9175471663, green: 0.9177045822, blue: 0.917537272, alpha: 1)
        sb.delegate = self //UISearch bar delegate
        return sb
    }()
    
    //filter out search text
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        //if search text is empty bring all users inside of list instead of empty string(blank controller)
        if searchText.isEmpty {
            filteredUsers = users
        } else {
            filteredUsers = self.users.filter { (user) -> Bool in
                return user.username.lowercased().contains(searchText.lowercased()) //case insensitive
            }
        }
        
        
        //filter gives back array of elements back
       filteredUsers =  self.users.filter { (user) -> Bool in
            return user.username.contains(searchText)
        }
        
        self.collectionView?.reloadData()
    }
    
    let cellId = "cellId" //safe string used to register cell class
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        
        navigationController?.navigationBar.addSubview(searchBar)
        let navBar = navigationController?.navigationBar
        searchBar.anchor(top: navBar?.topAnchor, left: navBar?.leftAnchor, bottom: navBar?.bottomAnchor, right: navBar?.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        
        //create registration for cells
        collectionView?.register(UserSearchCell.self, forCellWithReuseIdentifier: cellId)
        
        
        collectionView?.alwaysBounceVertical = true //bounce collection view up and down
        fetchUsers()
    }
    
    //method when user picks another user from search results
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let user = filteredUsers[indexPath.item]
        print(user.username)
        
    }
    
    
    
    var filteredUsers = [User]() //master of all users
    var users = [User]() //show fetched users from Firebase to controller
    
    //method to fetch users using Firebase database call
    fileprivate func fetchUsers() {
        print("Fetching users...")
        
        //fetch users underneath node from Firebase, snapshot value is dictionary itself
        let ref = Database.database().reference().child("users")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let dictionaries = snapshot.value as? [String: Any] else { return }
            
            //iterate through all objects inside dictionary to display list of users
            dictionaries.forEach({ (key, value) in
                
                //omit current username from the list
                if key == Auth.auth().currentUser?.uid {
                    print("Found myself, omit from list")
                    return
                }
                
                //cast value into user dictionary
                guard let userDictionary = value as? [String: Any] else { return }
                
                let user = User(uid: key, dictionary: userDictionary)
                self.users.append(user) //append user inside users array
                
                
            })
            
            self.users.sort(by: { (u1, u2) -> Bool in
                
                return u1.username.compare(u2.username) == .orderedAscending //alphabet order doesn't work all the time
            })
            
            self.filteredUsers = self.users //refresh filtered users
            self.collectionView?.reloadData() //reload the controller with users

            
        }) { (err) in
            print("Failed to fetch users for search:", err)
        }
    }
    
    
    //number of cells
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredUsers.count //return number of users from firebase
    }
    
    //create the cell
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! UserSearchCell
       
        cell.user = filteredUsers[indexPath.item] //for every row set the user
        
        return cell
    }
    
    //width and height of cells, conform to UICollectionViewDelegateFlowLayout first
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: view.frame.width, height: 66)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}
