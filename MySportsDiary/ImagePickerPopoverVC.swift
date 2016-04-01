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

class ImagePickerPopoverVC: UIViewController,
UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    /// The images shown in the image view
    private var images: [UIImage]?;
    /// Which image showing currently
    private var imageIndex = 0;
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var noImagesLabel: UILabel!
    @IBOutlet weak var imageControls: UIStackView!
    
    
    
    ///
    /// App lifecycle methods
    ///
    override func viewDidLoad() {
        super.viewDidLoad();
        let app = UIApplication.sharedApplication()
        NSNotificationCenter.defaultCenter()
            .addObserver(self,
                         selector: #selector(applicationWillResignActive(_:)),
                         name: UIApplicationWillResignActiveNotification,
                         object: app);
        
    }
    
    func applicationWillResignActive(notification: NSNotification) {
        saveTempImages();
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        loadTempImages();
        setCurrentImage();
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated);
        saveTempImages();
    }
    
    ///
    /// Action handlers
    ///
    @IBAction func onLibraryButtonPressed(sender: AnyObject) {
        pickImageFrom(.PhotoLibrary)
    }
    
    @IBAction func onPhotoButtonPressed(sender: AnyObject) {
        pickImageFrom(.Camera)
    }
    
    @IBAction func onPrevious(sender: AnyObject) {
        if let images = images where images.count > 1 {
            let decrementedIndex = imageIndex - 1;
            if decrementedIndex < 0 {
                imageIndex = images.count - 1;
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
    
    @IBAction func onDelete(sender: AnyObject) {
        if images != nil && imageIndex < images!.count {
            let controller = UIAlertController(title: "Delete the image?",message: nil,preferredStyle: .ActionSheet)
            let yesAction = UIAlertAction(title: "Yes",style: .Default, handler: { action in
                self.images!.removeAtIndex(self.imageIndex);
                DataManager.getManagerInstance().removeTempImage(self.imageIndex);
                self.imageIndex -= max(0, self.imageIndex);
                self.setCurrentImage();
            });
            controller.addAction(yesAction)
            controller.addAction(UIAlertAction(title: "No",style: .Cancel,handler: nil))
            presentViewController(controller, animated: true, completion: nil)
            
        }
    }
    
    ///
    /// When the user picks image, via camera or library
    ///
    func pickImageFrom(sourceType: UIImagePickerControllerSourceType) {
        if let mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(sourceType)
            where UIImagePickerController.isSourceTypeAvailable(sourceType)
                && mediaTypes.contains(kUTTypeImage as String) {
            let picker = UIImagePickerController()
            picker.mediaTypes = [kUTTypeImage as String];
            picker.delegate = self
            picker.allowsEditing = true;
            picker.sourceType = sourceType
            presentViewController(picker,animated: true, completion: nil);
            
        } else {
            let alertController = UIAlertController(title: "The device does not have a camera.",
                                                    message: nil,
                                                    preferredStyle: UIAlertControllerStyle.Alert);
            let okAction = UIAlertAction(title: "OK",
                                         style: UIAlertActionStyle.Cancel, handler: nil);
            alertController.addAction(okAction);
            presentViewController(alertController,animated: true, completion: nil);
            
        }
        
    }
    
    ///
    /// When we receive an image from the user...
    ///
    func imagePickerController(picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            if images == nil {
                images = Array<UIImage>();
                imageIndex = 0 ;
            }
            images!.append(image);
            imageIndex = images!.count - 1;
            DataManager.getManagerInstance().saveTempImage(image);
            setCurrentImage();
            
        }
        picker.dismissViewControllerAnimated(true, completion: nil);
    }
    
    ///
    /// On image pick cancellation
    ///
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion:nil)
    }
    
    
    
    private func setCurrentImage() {
        if let images = images where images.count > imageIndex {
            let image = images[imageIndex];
            photoImageView.image = image;
            photoImageView.hidden = false;
            noImagesLabel.hidden = true;
            imageControls.hidden = false;
        } else {
            photoImageView.hidden = true;
            noImagesLabel.hidden = false;
            imageControls.hidden = true;
        }
        
    }
    
    func loadTempImages() {
        guard images != nil else {
            images = DataManager.getManagerInstance().getTempImages();
            return;
        }
    }
    
    func saveTempImages() {
        //        if let images = images {
        //            DataManager.getManagerInstance().setTempImages(images);
        //        }
    }
    
    
}
