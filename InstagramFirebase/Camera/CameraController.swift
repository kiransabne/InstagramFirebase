//
//  CameraController.swift
//  InstagramFirebase
//
//  Created by everipedia_iMac on 12/10/17.
//  Copyright © 2017 Christian Deciga. All rights reserved.
//

import UIKit
import AVFoundation

class CameraController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //show camera and what the ouput is
        setupCaptureSession()
        
    }
    
    fileprivate func setupCaptureSession() {
        let captureSession = AVCaptureSession()
        
        //1. setup inputs
        let captureDevice = AVCaptureDevice.default(for: .video)
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
                
            }
            
        } catch let err {
            print("Could not setup camera input:", err)
        }
        

    
        
        //2. setup outputs
        
        //3.setup output preview
        
    }
    
}
