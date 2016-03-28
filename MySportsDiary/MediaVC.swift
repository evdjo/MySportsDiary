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
    var image: UIImage?
    var videoURL: NSURL?
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        if let image = image {
            photoImageView.image = image;
            photoImageView.hidden = false;
        } else {
            photoImageView.hidden = true;
        }
        
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
                image = info[UIImagePickerControllerEditedImage] as? UIImage
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
}
