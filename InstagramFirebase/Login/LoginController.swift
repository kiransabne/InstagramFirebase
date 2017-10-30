//
//  LoginController.swift
//  InstagramFirebase
//
//  Created by everipedia_iMac on 10/30/17.
//  Copyright © 2017 Christian Deciga. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        view.addSubview(signUpButton)
        signUpButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
