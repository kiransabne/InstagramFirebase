//
//  PhotoSelectorController.swift
//  InstagramFirebase
//
//  Created by everipedia_iMac on 11/3/17.
//  Copyright © 2017 Christian Deciga. All rights reserved.
//

import UIKit

class PhotoSelectorController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        
        setupNavigationButtons()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true //hide status bar
    }
    
    
    fileprivate func setupNavigationButtons() {
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(handleNext))
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleNext() {
        print("handling next")
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
