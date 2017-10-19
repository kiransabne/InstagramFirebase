//
//  ViewController.swift
//  InstagramFirebase
//
//  Created by everipedia_iMac on 10/18/17.
//  Copyright © 2017 Christian Deciga. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //create button programmatically
    let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        //button.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false //use this for constraints programatically
        return button
    }()
    
    //create text field programatically
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.translatesAutoresizingMaskIntoConstraints = false //required for hard coded constraints
        tf.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 0.2132707634) //background color using color literal
        tf.borderStyle = .roundedRect //border for text field
        tf.font = UIFont(name: "Avenir", size: 14)
        return tf
    }()
    
    
    //create text field programatically
    let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Username"
        tf.translatesAutoresizingMaskIntoConstraints = false //required for hard coded constraints
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
        tf.translatesAutoresizingMaskIntoConstraints = false //required for hard coded constraints
        tf.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 0.2132707634) //background color using color literal
        tf.borderStyle = .roundedRect //border for text field
        tf.font = UIFont(name: "Avenir", size: 14)
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(plusPhotoButton)
        
        //anchors for auto-layout programmatically button
        plusPhotoButton.heightAnchor.constraint(equalToConstant: 140).isActive = true //required for autolayout
        
        plusPhotoButton.widthAnchor.constraint(equalToConstant: 140).isActive = true
        plusPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        plusPhotoButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
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
    
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, usernameTextField, passwordTextField])
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually //distribution of the stack view
        stackView.axis = .vertical
        stackView.spacing = 10
        view.addSubview(stackView) //add to viewcontroller
        
        
        //use array to activate constraints
        NSLayoutConstraint.activate([stackView.topAnchor.constraint(equalTo: plusPhotoButton.bottomAnchor, constant: 20),
         stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
         stackView.heightAnchor.constraint(equalToConstant: 200)])
        
        
        
    }
    
}













