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

/// video or image
    var mediaType: String!;

/// Video stuff
    var movieToPlay: NSURL?;
    let persistentTempMovie = fileURL(file: "tempVideo.MOV", under: .CachesDirectory);
    var avPlayerViewController: AVPlayerViewController?;

/// Image stuff
    var imageCountDelegate: ImageCountDelegate?; /// when the count of images changes
    private var images: [UIImage]?; /// The images shown in the image view
    private var imageIndex = 0; /// Which image showing currently

    @IBOutlet weak var photoImageView: UIImageView!;
    @IBOutlet weak var noImagesLabel: UILabel!;
    @IBOutlet var imageControls: UIView!
    @IBOutlet weak var useCameraButton: UIButton!
    @IBOutlet weak var controlsStackView: UIStackView!
    @IBOutlet weak var deleteButton: UIButton!

/// the containers
    @IBOutlet weak var videoContainer: UIView!;
    @IBOutlet weak var imageContainer: UIView!

///
/// Load any temp images, and show the first
///
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        if (mediaType == kUTTypeImage as String) {
            appearedSetForImage();
        } else if (mediaType == kUTTypeMovie as String) {
            appearedSetForVideo();
        }
    }
    private func appearedSetForImage() {
        useCameraButton.setImage(UIImage(named: "photo-cam"), forState: .Normal);
        imageContainer.hidden = false;
        imageControls.hidden = false;
        imageControls.subviews.forEach({ view in view.hidden = false; });
        videoContainer.hidden = true ;
        loadTempImages();
        setCurrentImage();
    }
    private func appearedSetForVideo() {
        useCameraButton.setImage(UIImage(named: "video-cam"), forState: .Normal);
        imageContainer.hidden = true;
        imageControls.hidden = true;
        imageControls.subviews.forEach({ view in view.hidden = true; });
        videoContainer.hidden = false ;

        loadTempVideo();

        if (avPlayerViewController == nil) {
            avPlayerViewController = AVPlayerViewController();
            let avPlayerView = avPlayerViewController!.view;
            avPlayerView.frame = videoContainer.frame;
            avPlayerView.clipsToBounds = true;
            videoContainer.addSubview(avPlayerView);
        }
        if let url = movieToPlay {
            avPlayerViewController!.player = AVPlayer(URL: url)
            avPlayerViewController!.view.hidden = false
        }
    }

    func loadTempVideo() {
        if let path = persistentTempMovie.path where NSFileManager.defaultManager().fileExistsAtPath(path) {
            movieToPlay = persistentTempMovie
        } else {
            movieToPlay = nil;
        }
    }

    @IBAction func onLibraryButtonPressed(sender: AnyObject) { pickFromLibrary() }
    @IBAction func onCameraButtonPressed(sender: AnyObject) { pickUsingCamera(); }

///
/// Shoot new photo using the camera
///
    func pickUsingCamera() {
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
    func pickFromLibrary() {
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
        picker.mediaTypes = [mediaType];
        picker.delegate = self
        picker.allowsEditing = false;
        picker.sourceType = sourceType;
        picker.videoMaximumDuration = NSTimeInterval(30.0);
        presentViewController(picker, animated: true, completion: nil);
    }

///
/// When we receive an media from the user
///
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String: AnyObject]) {

            if mediaType == kUTTypeImage as NSString,
                let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
                    if images == nil {
                        images = Array<UIImage>();
                        imageIndex = 0 ;
                    }
                    images!.append(image);
                    imageIndex = images!.count - 1;
                    DataManager.getManagerInstance().saveTempImage(image);
                    imageCountDelegate?.onImageCountChange();
                    setCurrentImage();
            } else if mediaType == kUTTypeMovie as NSString {
                    if let movieURL = info[UIImagePickerControllerMediaURL] as? NSURL {
                        deleteFile(file: persistentTempMovie);
                        myCopy(movieURL, toPath: persistentTempMovie);
                        movieToPlay = persistentTempMovie;
                    }
            }
            picker.dismissViewControllerAnimated(true, completion: nil);
    }

///
/// On pick cancel
///
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
///
/// If we have images in the images array, set the one at position image index to our image view
/// else hide the image view, along with the controls assosicated with it
///
    private func setCurrentImage() {
        if let images = images where images.count > imageIndex && 0 <= imageIndex {
            photoImageView.image = images[imageIndex];
            noImagesLabel.hidden = true;
            imageControls.hidden = false;
            deleteButton.hidden = false;
        } else {
            photoImageView.image = nil;
            noImagesLabel.hidden = false;
            imageControls.hidden = true;
            deleteButton.hidden = true;
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
            imageIndex = imageIndex - 1 < 0 ? images.count - 1: imageIndex - 1;
            setCurrentImage();
        }
    }

    @IBAction func onNext(sender: AnyObject) {
        if let images = images where images.count > 1 {
            imageIndex = imageIndex + 1 < images.count ? imageIndex + 1: 0;
            setCurrentImage();
        }
    }

    @IBAction func onDelete(sender: AnyObject) {
        if (mediaType == kUTTypeImage as String) {
            if let images = self.images where images.count > imageIndex {
                let controller = UIAlertController(title: deleteTheImageText,
                    message: nil, preferredStyle: .ActionSheet)

                let yesAction = UIAlertAction(title: yes, style: .Destructive, handler: {
                    action in
                    self.images!.removeAtIndex(self.imageIndex);
                    DataManager.getManagerInstance().removeTempImage(self.imageIndex);
                    self.imageCountDelegate?.onImageCountChange();
                    self.imageIndex = max(0, self.imageIndex - 1);
                    self.setCurrentImage();
                });
                controller.addAction(yesAction)
                controller.addAction(UIAlertAction(title: no, style: .Cancel, handler: nil))
                presentViewController(controller, animated: true, completion: nil)
            }
        } else if (mediaType == kUTTypeMovie as String) {
            if let player = avPlayerViewController?.player {
                player.pause()
                let controller = UIAlertController(title: "Delete the video?",
                    message: nil, preferredStyle: .ActionSheet)

                let yesAction = UIAlertAction(title: yes, style: .Destructive, handler: {
                    action in
                    self.movieToPlay = nil;
                    deleteFile(file: self.persistentTempMovie);
                    self.avPlayerViewController!.player = nil;
                });
                controller.addAction(yesAction)
                controller.addAction(UIAlertAction(title: no, style: .Cancel, handler: nil))
                presentViewController(controller, animated: true, completion: nil)
            }
        }
    }
}
