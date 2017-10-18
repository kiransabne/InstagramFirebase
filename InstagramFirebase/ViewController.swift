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
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false //use this for constraints programatically
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(plusPhotoButton)
        
        //anchors for auto-layout
        plusPhotoButton.heightAnchor.constraint(equalToConstant: 140).isActive = true //required for autolayout
        
        plusPhotoButton.widthAnchor.constraint(equalToConstant: 140).isActive = true
        plusPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        plusPhotoButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        

    }

    


}

