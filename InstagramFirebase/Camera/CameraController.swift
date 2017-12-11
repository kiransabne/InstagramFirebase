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
    
    
    //dismiss button
    let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "right_arrow_shadow"), for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    //method for dismiss button
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
        print("handling dismiss..")
    }
    
    
    //capturePhotoButton
    let capturePhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "capture_photo"), for: .normal)
        button.addTarget(self, action: #selector(handleCapturePhoto), for: .touchUpInside)
        return button
    }()
    
    //method when user taps capture photo
    @objc func handleCapturePhoto() {
        print("Capturing photo...")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //show camera and what the ouput is
        setupCaptureSession()
        
        view.addSubview(capturePhotoButton)
        capturePhotoButton.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 24, paddingRight: 0, width: 80, height: 80)
        capturePhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true //center camera horizontally
    }
    
    fileprivate func setupCaptureSession() {
        let captureSession = AVCaptureSession()
        
        //1. setup inputs checking for device
        let captureDevice = AVCaptureDevice.default(for: .video)
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
                
            }
            
        } catch let err {
            print("Could not setup camera input:", err)
        }
        
        
        //2. setup outputs taking photos
        let output = AVCapturePhotoOutput()
        //check to see if can add output
        if captureSession.canAddOutput(output) {
            captureSession.addOutput(output)
        }
        
        
        //3.setup output preview layer
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.frame
        view.layer.addSublayer(previewLayer) //put inside of view
        
        captureSession.startRunning() //cause AVSession to use input to pipe output show what camera is seeing
        
    }
    
}













