//
//  MediaVC.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 27/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import MobileCoreServices

class MediaPopoverVC: UIViewController,
UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var lastMedia: String?
    var AVPlayerVC: AVPlayerViewController?
    
    
    var images: [UIImage?]?;
    var imageIndex = 0;
    
    
    var videoURL: NSURL?
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        imageIndex = 0;
        setCurrentImage();
        super.viewDidAppear(animated);
    }
    
    
    
    
    @IBAction func onLibraryButtonPressed(sender: AnyObject) {
        pickMediaFromSource(UIImagePickerControllerSourceType.PhotoLibrary)
        
    }
    
    @IBAction func onPhotoButtonPressed(sender: AnyObject) {
        pickMediaFromSource(UIImagePickerControllerSourceType.Camera)
    }
    
    
    
    func pickMediaFromSource(sourceType: UIImagePickerControllerSourceType) {
        let mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(sourceType)!;
        if UIImagePickerController.isSourceTypeAvailable(sourceType)
            && mediaTypes.count > 0 {
            let picker = UIImagePickerController()
            picker.mediaTypes = mediaTypes
            picker.delegate = self
            picker.allowsEditing = true;
            picker.sourceType = sourceType
            presentViewController(picker,animated: true, completion: nil);
            
        } else {
            let alertController = UIAlertController(title: "Error accessing media",
                                                    message: "Unsupported media source. ",
                                                    preferredStyle: UIAlertControllerStyle.Alert);
            let okAction = UIAlertAction(title: "OK",
                                         style: UIAlertActionStyle.Cancel, handler: nil);
            alertController.addAction(okAction);
            presentViewController(alertController,animated: true, completion: nil);
            
        }
        
    }
    
    
    
    func imagePickerController(picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        lastMedia = info[UIImagePickerControllerMediaType] as? String
        if let mediaType = lastMedia {
            if mediaType == kUTTypeImage as NSString {
                if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
                    DataManager.getManagerInstance().saveTempImage(image);
                    imageIndex += 1;
                    setCurrentImage();
                }
            } else if mediaType == kUTTypeMovie as NSString {
                videoURL = info[UIImagePickerControllerMediaURL] as? NSURL
            }
            picker.dismissViewControllerAnimated(true, completion: nil);
            
        }
        
        //        self.dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion:nil)
        //        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    
    private func setCurrentImage() {
        images = DataManager.getManagerInstance().getTempImages();
        if let images = images where images.count > imageIndex, let image = images[imageIndex] {
            photoImageView.image = image;
            photoImageView.hidden = false;
        } else {
            photoImageView.hidden = true;
        }
        
    }
    
    @IBAction func onPrevious(sender: AnyObject) {
        if let images = images where images.count > 1 {
            let decrementedIndex = imageIndex - 1;
            if decrementedIndex < 0 {
                imageIndex = images.count;
            } else {
                imageIndex = decrementedIndex;
            }
            
            setCurrentImage();
            
        }
    }
    
    @IBAction func onNext(sender: AnyObject) {
        
        if let images = images where images.count > 1 {
            let incrementedIndex = imageIndex + 1;
            if incrementedIndex < images.count {
                imageIndex = incrementedIndex;
            } else {
                imageIndex = 0;
            }
            
            setCurrentImage();
            
        }
        
    }
    
    
    
}
