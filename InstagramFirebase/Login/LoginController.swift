//
//  LoginController.swift
//  InstagramFirebase
//
//  Created by everipedia_iMac on 10/30/17.
//  Copyright © 2017 Christian Deciga. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {
    
    //create UIView programatically
    let logoContainerView: UIView = {
        let view = UIView()
        
        let logoImageView = UIImageView(image: #imageLiteral(resourceName: "Instagram_logo_white"))
        logoImageView.contentMode = .scaleAspectFill
        
        view.addSubview(logoImageView)
        logoImageView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 50)
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
        view.backgroundColor = #colorLiteral(red: 0.002050609095, green: 0.5223442316, blue: 0.7138667703, alpha: 1)
        return view
    }()
    
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
    
    @objc func handleTextInputChange() {
        //change signup button to original color while editing use boolean value
        let isFormValid = emailTextField.text?.characters.count ?? 0 > 0 && passwordTextField.text?.characters.count ?? 0 > 0
        
        //check
        if isFormValid {
            loginButton.isEnabled = true
            loginButton.backgroundColor = #colorLiteral(red: 0.002071890514, green: 0.6539129615, blue: 0.9284040332, alpha: 1)
        } else {
            loginButton.isEnabled = false //turn sign up button dark blue when user enters all fields
            loginButton.backgroundColor = #colorLiteral(red: 0.5955938697, green: 0.829785049, blue: 0.9551936984, alpha: 1)
        }
        
        
    }
    
    
    
    
    //programmatically create button at bottom of login controller
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.5874177217, green: 0.8298925757, blue: 0.9511969686, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        //add action when pressed
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        button.isEnabled = false
        return button
        
    }()
    
    @objc func handleLogin() {
        //execute logging back in using Firebase
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, err) in
            
          //if cannont sign in then
            if let err = err {
                print("Failed to sign in with email:", err)
                return
            }
            
            print("Successfully logged back in with user:", user?.uid ?? "")
        })
    }
    
    
    
    //don't have account  button
    let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account? ", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        
        attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.002071890514, green: 0.6539129615, blue: 0.9284040332, alpha: 1)]))
        
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        
        return button
    }()
    
    
    //func for add action handleShowSignUp
    @objc func handleShowSignUp() {
        //present registration controller
        let signUpController = SignUpController()
        print(navigationController)
        navigationController?.pushViewController(signUpController, animated: true)
    }
    
    //customize status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent //render white text
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(logoContainerView) //add UIView Logo to Controller
        logoContainerView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 150)
        
        
        
        navigationController?.isNavigationBarHidden = true //hide navigationbar
        
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        setupInputFields()
    }
    
    fileprivate func setupInputFields() {
        
        //create stack view for buttons programatically
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
        
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        stackView.anchor(top: logoContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 40, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 140)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
