//
//  ViewController.swift
//  InstagramFirebase
//
//  Created by everipedia_iMac on 10/18/17.
//  Copyright © 2017 Christian Deciga. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    //create button programmatically
    let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo").withRenderingMode(.alwaysOriginal), for: .normal)
        
        return button
    }()
    
    //create text field programatically
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        
        tf.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 0.2132707634) //background color using color literal
        tf.borderStyle = .roundedRect //border for text field
        tf.font = UIFont(name: "Avenir", size: 14)
        return tf
    }()
    
    
    //create text field programatically
    let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Username"
        
        tf.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 0.2132707634) //background color using color literal
        tf.borderStyle = .roundedRect //border for text field
        tf.font = UIFont(name: "Avenir", size: 14)
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
        
        return tf
    }()
    
    
    //sign up button
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
    
        button.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
       
        
        button.layer.cornerRadius = 5
        button.titleLabel?.font =  UIFont(name: "Avenir", size: 14)
        button.setTitleColor(.white, for: .normal)
        
        //action when Sign up button is pressed
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        
        
        return button
    }()
    
    //method when signup button is pressed by user
    @objc func handleSignUp() {
        
        //guard statement to grab user input
        guard let email = emailTextField.text else { return }
        guard let username = usernameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        
        
        //authenticate with Firebase
        Auth.auth().createUser(withEmail: email, password: password, completion: {
            (user: User?, error: Error?) in
            //check to see if there was an error
            
            if let err = error {
                print("Failed to create user:", err)
            }
            
            //if no error, we are successful
            print("Successfully created user:", user?.uid ?? "")
        })
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

//anchor extension
extension UIView {
    //anchoring method for constraints on Stackview
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
        
        //everytime anchoring something set it to false
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
}












