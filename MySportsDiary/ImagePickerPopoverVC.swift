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
import Photos
import MobileCoreServices

class ImagePickerPopoverVC: UIViewController,
UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    private let noPhotoLibraryMessage = "The device does have photo library."
    private let noCameraMessage = "The device does have camera."

    private let deniedMessagePhotoLib = "You've denied permission of this app to use the photo library. You can grant permission in the settings menu.";
    private let deniedMessageCamera = "You've denied permission of this app to use the camera device. You can grant permission in the settings menu.";
    private let takeMeThereText = "Take me there";
    private let cancelText = "Cancel";
    private let noAccessMessagePhotoLib = "Cannot access your photo library.";
    private let noAccessMessageCamera = "Cannot access your camera device.";
    private let deleteTheImageText = "Delete the image?";
    private let yes = "Yes";
    private let no = "No";
    private let cancel = "Cancel";

/// The images shown in the image view
    var imageCountDelegate: ImageCountDelegate?;
    private var images: [UIImage]?;
/// Which image showing currently
    private var imageIndex = 0;
    @IBOutlet weak var photoImageView: UIImageView!;
    @IBOutlet weak var noImagesLabel: UILabel!;
    @IBOutlet var imageControls: UIView!

///
/// Load any temp images, and show the first
///
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);

        loadTempImages();
        setCurrentImage();
    }

    @IBAction func onLibraryButtonPressed(sender: AnyObject) { pickImageFromPhotoLibrary() }
    @IBAction func onPhotoButtonPressed(sender: AnyObject) { pickImageUsingCamera(); }

///
/// Shoot new photo using the camera
///
    func pickImageUsingCamera() {
        guard imagePickerMediaAvailable(.Camera) else {
            alertWithMessage(self, title: noCameraMessage);
            return;
        }
        let authorisationStatus = AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo);
        switch (authorisationStatus) {
        case .Authorized: self.presentImagePickerFor(.Camera);
        case .NotDetermined: AVCaptureDevice.requestAccessForMediaType(AVMediaTypeVideo,
            completionHandler: { (granted) in
                if granted { self.presentImagePickerFor(.Camera) } })
        case .Denied: binaryChoiceMessage(self,
            title: deniedMessageCamera,
            choice0: takeMeThereText,
            handler0: { (_) in goToSettings(); },
            choice1: cancelText,
            handler1: nil);
        case .Restricted: alertWithMessage(self, title: noAccessMessageCamera);
        }
    }

///
/// Choose from library (folder button selected)
///
    func pickImageFromPhotoLibrary() {
        guard imagePickerMediaAvailable(.PhotoLibrary) else {
            alertWithMessage(self, title: noPhotoLibraryMessage);
            return;
        }
        let authorisationStatus = PHPhotoLibrary.authorizationStatus();
        switch (authorisationStatus) {

        case .Authorized: self.presentImagePickerFor(.PhotoLibrary);
        case .NotDetermined: PHPhotoLibrary.requestAuthorization({ (newAuthStatus) in
            if newAuthStatus == .Authorized { self.presentImagePickerFor(.PhotoLibrary); }
            });

        case .Denied: binaryChoiceMessage(self,
            title: deniedMessagePhotoLib,
            choice0: takeMeThereText,
            handler0: { (_) in goToSettings(); },
            choice1: cancelText,
            handler1: nil);

        case .Restricted: alertWithMessage(self, title: noAccessMessagePhotoLib);
        }
    }
///
/// Present image picker view controller -- either from camera or photo library
///
    private func presentImagePickerFor(sourceType: UIImagePickerControllerSourceType) {
        let picker = UIImagePickerController()
        picker.mediaTypes = [kUTTypeImage as String];
        picker.delegate = self
        picker.allowsEditing = false;
        picker.sourceType = sourceType
        presentViewController(picker, animated: true, completion: nil);
    }

///
/// When we receive an image from the user
///
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String: AnyObject]) {

            if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
                if images == nil {
                    images = Array<UIImage>();
                    imageIndex = 0 ;
                }
                images!.append(image);
                imageIndex = images!.count - 1;
                DataManager.getManagerInstance().saveTempImage(image);
                imageCountDelegate?.onImageCountChange();
                setCurrentImage();
            }
            picker.dismissViewControllerAnimated(true, completion: nil);
    }

///
/// On image pick cancel
///
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
///
/// If we have images in the images array, set the one at position image index to our image view
/// else hide the image view, along with the controls assosicated with it
///
    private func setCurrentImage() {
        if let images = images where images.count > imageIndex {
            let image = images[imageIndex];
            photoImageView.image = image;
            noImagesLabel.hidden = true;
            imageControls.hidden = false;
        } else {
            photoImageView.image = nil;
            noImagesLabel.hidden = false;
            imageControls.hidden = true;
        }
    }
///
/// Load any temp images
///
    func loadTempImages() {
        if images == nil {
            images = DataManager.getManagerInstance().getTempImages();
        }
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
            let controller = UIAlertController(
                title: deleteTheImageText,
                message: nil,
                preferredStyle: .ActionSheet)
            let yesAction = UIAlertAction(
                title: yes,
                style: .Default,
                handler: {
                    action in
                    self.images!.removeAtIndex(self.imageIndex);
                    DataManager.getManagerInstance().removeTempImage(self.imageIndex);
                    self.imageCountDelegate?.onImageCountChange();
                    self.imageIndex -= max(0, self.imageIndex);
                    self.setCurrentImage();
            });
            controller.addAction(yesAction)
            controller.addAction(UIAlertAction(title: no, style: .Cancel, handler: nil))
            presentViewController(controller, animated: true, completion: nil)
        }
    }
}
