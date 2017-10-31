//
//  LoginController.swift
//  InstagramFirebase
//
//  Created by everipedia_iMac on 10/30/17.
//  Copyright © 2017 Christian Deciga. All rights reserved.
//

import UIKit

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
    
    //programmatically create button
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Don't have an account? Sign Up.", for: .normal)
        //add action when pressed
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
        
        view.addSubview(signUpButton)
        signUpButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
