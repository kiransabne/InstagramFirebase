//
//  PhotoSelectorController.swift
//  InstagramFirebase
//
//  Created by everipedia_iMac on 11/3/17.
//  Copyright © 2017 Christian Deciga. All rights reserved.
//

import UIKit
import Photos


class PhotoSelectorController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    let headerId = "headerId"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        setupNavigationButtons()
        
        //register a custom cell inside controller
        collectionView?.register(PhotoSelectorCell.self, forCellWithReuseIdentifier: cellId)
        
        //register a header
        collectionView?.register(PhotoSelectorHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        
        
        fetchPhotos()

    }
    
    //handle the selection of cells inside collectionview
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedImage = images[indexPath.item] //reference to whatever the selection is
        self.collectionView?.reloadData() //render the header
        
        let indexPath = IndexPath(item: 0, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
       
    }
    
    
    var selectedImage: UIImage?
    var images = [UIImage]() //empty image array
    var assets = [PHAsset]() //empty PHAssets array
    
    //refactored into
    fileprivate func assetsFetchOptions() -> PHFetchOptions {
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.fetchLimit = 30
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false) //fetch latest photos
        fetchOptions.sortDescriptors = [sortDescriptor] //fetch latest photos
        
        return fetchOptions
    }
    
    
    
    //func to retrieve photos
    fileprivate func fetchPhotos() {
        
        let allPhotos = PHAsset.fetchAssets(with: .image, options: assetsFetchOptions())
        
        //background thread so UI doesn't hang reduce hanging behavior when presenting fetch photos
        DispatchQueue.global(qos: .background).async {
            
            allPhotos.enumerateObjects ({ (asset, count, stop) in
                print(count)
                let imageManager = PHImageManager.default()
                let targetSize = CGSize(width: 200, height: 200)
                let options = PHImageRequestOptions()
                options.isSynchronous = true
                
                imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: options, resultHandler: { (image, info) in
                    
                    if let image = image {
                        self.images.append(image)
                        self.assets.append(asset)
                        
                        //set first photo as default upon opening photoselector
                        if self.selectedImage == nil {
                            self.selectedImage = image
                        }
                    }
                    
                    if count == allPhotos.count - 1 {
                        
                        //get back on main thread
                        DispatchQueue.main.async {
                            self.collectionView?.reloadData()
                            
                        }
        
                        
                    }
                })
            })
            
        }
    
    }
    
    //spacing for header view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
    }
    
    //provide size for header
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let width = view.frame.width
        return CGSize(width: width, height: width)
    }
    
    
    
    //override method to render view for header
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! PhotoSelectorHeader
            
        header.photoImageView.image = selectedImage
        if let selectedImage = selectedImage {
            if let index = self.images.index(of: selectedImage) {
               let selectedAsset = self.assets[index]
                
                //request larger image for header
                let imageManager = PHImageManager.default()
                let targetSize = CGSize(width: 600, height: 600)
                imageManager.requestImage(for: selectedAsset, targetSize: targetSize, contentMode: .default, options: nil, resultHandler: { (image, info ) in
                    
                    
                    header.photoImageView.image = image
                    
                    
                    
                })
                
                
                
            }
            
        }
        
        
        
        return header
    }
    
    
    
    //mininum interitem spacing to get vertical spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    
    //mininum line spacing horizontal
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 1
    }
    
    
    //customize size of the cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (view.frame.width - 3) / 4 //declare width
        
        return CGSize(width: width, height: width)
    }
    
    
    //number of cells shown 
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //return some kind of cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PhotoSelectorCell
        
        cell.photoImageView.image = images[indexPath.item] //slot collectionview rendering out the cell
        
        
        return cell
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
        //push on to navigation stack in new controller
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
