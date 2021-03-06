//
//  SignUpController.swift
//  InstagramFirebase
//
//  Created by everipedia_iMac on 10/18/17.
//  Copyright © 2017 Christian Deciga. All rights reserved.
//

import UIKit
import Firebase

class SignUpController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //create button programmatically
    let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo").withRenderingMode(.alwaysOriginal), for: .normal)
        
        //action for button user to add photo profile
        button.addTarget(self, action: #selector(handlePlusPhoto), for: .touchUpInside)
        
        return button
    }()
    
    //allows user to add profile photo pressing on button
    @objc func handlePlusPhoto() {
       
        //access camera
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    //check what image user chose to display in button image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            
            plusPhotoButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
            
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
             plusPhotoButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
            
        }
        
        //style button
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width / 2 //rounded
        plusPhotoButton.layer.masksToBounds = true //required to show rounded button
        plusPhotoButton.layer.borderColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        plusPhotoButton.layer.borderWidth = 3
        
        
        dismiss(animated: true, completion: nil) //dismiss the picker controller
    }
    
    
    //create text field programatically
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        
        tf.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 0.2132707634) //background color using color literal
        tf.borderStyle = .roundedRect //border for text field
        tf.font = UIFont(name: "Avenir", size: 14)
        
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        
        return tf
    }()
    
    
    @objc func handleTextInputChange() {
        //change signup button to original color while editing use boolean value
        let isFormValid =  emailTextField.text?.characters.count ?? 0 > 0 && usernameTextField.text?.characters.count ?? 0 > 0 && passwordTextField.text?.characters.count ?? 0 > 0
        
        //check
        if isFormValid {
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = #colorLiteral(red: 0.8895385409, green: 0.1977875752, blue: 0.1538820841, alpha: 1)
        } else {
            signUpButton.isEnabled = false //turn sign up button dark blue when user enters all fields
            signUpButton.backgroundColor = #colorLiteral(red: 0.6538158846, green: 0.08525913242, blue: 0.3793562864, alpha: 1)
        }
        
        
    }
    
    
    
    //create text field programatically
    let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Username"
        
        tf.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 0.2132707634) //background color using color literal
        tf.borderStyle = .roundedRect //border for text field
        tf.font = UIFont(name: "Avenir", size: 14)
        
        //listener action
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        
        return tf
    }()
    
    
    
    
    
    //create text field programatically
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        
        tf.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 0.2132707634) //background color using color literal
        tf.borderStyle = .roundedRect //border for text field
        tf.font = UIFont(name: "Avenir", size: 14)
        
        //listener action
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        
        
        return tf
    }()
    
    
    //sign up button
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
    
        button.backgroundColor = #colorLiteral(red: 0.5956160426, green: 0.8298718333, blue: 0.9511463046, alpha: 1)
       
        
        button.layer.cornerRadius = 5
        button.titleLabel?.font =  UIFont(name: "Avenir", size: 14)
        button.setTitleColor(.white, for: .normal)
        
        //action when Sign up button is pressed
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        
        button.isEnabled = false //disable by default
        
        return button
    }()
    
    //method when signup button is pressed by user
    @objc func handleSignUp() {
        
        //guard statement to grab user input
        //verify an empty string
        guard let email = emailTextField.text, email.characters.count > 0 else { return }
        
        guard let username = usernameTextField.text, username.characters.count > 0 else { return }
        guard let password = passwordTextField.text, password.characters.count > 0 else { return }
        
        
        
        //authenticate with Firebase
        Auth.auth().createUser(withEmail: email, password: password, completion: {
            (user: FirebaseAuth.User?, error: Error?) in
            //check to see if there was an error
            
            if let err = error {
                print("Failed to create user:", err)
            }
            
            //if no error, we are successful
            print("Successfully created user:", user?.uid ?? "")
            
            //access to button image
            guard let image = self.plusPhotoButton.imageView?.image else { return }
            
            guard let uploadData = UIImageJPEGRepresentation(image, 0.3) else { return }
            
            let filename = NSUUID().uuidString
            
            
            //upload image
            Storage.storage().reference().child("profile_images").child(filename).putData(uploadData, metadata: nil, completion: { (metadata, err)
                in
                
                if let err = err {
                    print("Failed to upload profile image:", err)
                    return
                }
                guard let profileImageUrl = metadata?.downloadURL()?.absoluteString else { return }
                
                print("Successfully uploaded profile image", profileImageUrl)
                
                
                //save user into Firebase database
                guard let uid = user?.uid else { return } //use guard to unwrap
                
                //object dictionaries
                let dictionaryValues = ["username": username, "profileImageUrl": profileImageUrl]
                let values = [uid: dictionaryValues] //dictionary object
                
                //set value call to append new user to existing one, so it doesn't delete the previous user
                Database.database().reference().child("users").updateChildValues(values, withCompletionBlock: { (err, ref)
                
                in
                
                //check potential error
                if let err = err {
                    print("Failed to save user into db:", err)
                return
                }
                //if successful
                print("Successfully saved user info to db")
                    
                    //attain reference to main UI
                    guard let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else { return }
                    
                    mainTabBarController.setupViewControllers()
                    
                    
                    self.dismiss(animated: true, completion: nil)
                })
                
                
            })
            
            
        })
        
    }
    
    //already have account  button
    let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: "Already have an account? ", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        
        attributedTitle.append(NSAttributedString(string: "Sign In", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.002071890514, green: 0.6539129615, blue: 0.9284040332, alpha: 1)]))
        
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleAlreadyHaveAccount), for: .touchUpInside)
        
        return button
    }()
    
    @objc func handleAlreadyHaveAccount() {
        //pop SignUpController back to LoginController
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        view.addSubview(plusPhotoButton)
        
        plusPhotoButton.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 140, height: 140)
        
        //anchors for auto-layout programmatically button
        //plusPhotoButton.heightAnchor.constraint(equalToConstant: 140).isActive = true //required for autolayout
        
        //plusPhotoButton.widthAnchor.constraint(equalToConstant: 140).isActive = true
        plusPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        //plusPhotoButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        
        
        
        setupInputFields()
        
        //constraints for emailTextField
        //view.addSubview(emailTextField)
        
        //use array to activate constraints
        //NSLayoutConstraint.activate([emailTextField.topAnchor.constraint(equalTo: plusPhotoButton.bottomAnchor, constant: 20),
          //  emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
           // emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
           // emailTextField.heightAnchor.constraint(equalToConstant: 50)])
        
    

    }

    //setup stackviews programmatically
    fileprivate func setupInputFields() {
    
        //render stackview
        let stackView = UIStackView(arrangedSubviews: [emailTextField, usernameTextField, passwordTextField, signUpButton])
        
        
    
        stackView.distribution = .fillEqually //distribution of the stack view
        stackView.axis = .vertical
        stackView.spacing = 10
        view.addSubview(stackView) //add to viewcontroller
        
        
        //use array to activate constraints
        //NSLayoutConstraint.activate([
         //stackView.heightAnchor.constraint(equalToConstant: 200)])
        
        //stackView.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 40, paddingBottom: 0, paddingRight: 40)
        
        stackView.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 200)
    }
    
}











