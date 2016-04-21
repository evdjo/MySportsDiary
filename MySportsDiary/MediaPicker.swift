//
//  ImagePicker.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 06/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import Photos
import MobileCoreServices

///
/// Media picker is class used to present the user with UIImagePickerController
/// Initialized with mediaType to specify what we want to capture -
/// either photos or videos.
/// The MediaPicker can use either the camera or the photos library
///
///
///
class MediaPicker: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	private let picker: UIImagePickerController;
	private let parentVC: UIViewController;
	private let mediaType: String;

	init(parentVC: UIViewController, mediaType: String) {
		self.parentVC = parentVC;
		picker = UIImagePickerController();
		self.mediaType = mediaType;
		super.init();

		picker.mediaTypes = [mediaType];
		picker.delegate = self;
		picker.allowsEditing = false;
		picker.videoMaximumDuration = NSTimeInterval(30.0);
		picker.videoQuality = .TypeLow;
	}

///
/// Present image picker view controller -- either from camera or photo library
///
	private func presentImagePickerFor(sourceType: UIImagePickerControllerSourceType) {
		dispatch_async(dispatch_get_main_queue(), {
			self.picker.sourceType = sourceType;
			self.parentVC.presentViewController(self.picker, animated: true, completion: nil);
		});
	}

///
/// Shoot new using the camera
///
	func pickUsingCamera() {
		guard imagePickerMediaAvailable(.Camera) else {
			alertWithMessage(parentVC, title: noCameraMessage);
			return;
		}
		let authorisationStatus = AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo);
		switch (authorisationStatus) {
		case .Authorized: self.presentImagePickerFor(.Camera);
		case .NotDetermined: AVCaptureDevice.requestAccessForMediaType(AVMediaTypeVideo,
			completionHandler: { (granted) in
				if granted { self.presentImagePickerFor(.Camera) } })
		case .Denied: binaryChoiceMessage(parentVC, title: deniedMessageCamera,
			choice0: takeMeThereText, handler0: { (_) in goToSettings(); }, choice1: cancelText,
			handler1: nil);
		case .Restricted: alertWithMessage(parentVC, title: noAccessMessageCamera);
		}
	}

///
/// Choose from photos
///
	func pickFromLibrary() {
		guard imagePickerMediaAvailable(.PhotoLibrary) else {
			alertWithMessage(parentVC, title: noPhotoLibraryMessage);
			return;
		}
		let authorisationStatus = PHPhotoLibrary.authorizationStatus();
		switch (authorisationStatus) {
		case .Authorized: self.presentImagePickerFor(.PhotoLibrary);
		case .NotDetermined: PHPhotoLibrary.requestAuthorization({ (newAuthStatus) in
			if newAuthStatus == .Authorized { self.presentImagePickerFor(.PhotoLibrary); }
			});
		case .Denied: binaryChoiceMessage(parentVC, title: deniedMessagePhotoLib,
			choice0: takeMeThereText, handler0: { (_) in goToSettings(); }, choice1: cancelText,
			handler1: nil);
		case .Restricted: alertWithMessage(parentVC, title: noAccessMessagePhotoLib);
		}
	}

///
/// When we receive an media from the user
///
	func imagePickerController(picker: UIImagePickerController,
		didFinishPickingMediaWithInfo info: [String: AnyObject]) {
			if mediaType == kUTTypeImage as NSString,
				let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
					(parentVC as? MediaPopoverImagesVC)?.onNewImage(image);
			} else if mediaType == kUTTypeMovie as NSString {
					if let videoURL = info[UIImagePickerControllerMediaURL] as? NSURL {
						(parentVC as? MediaPopoverVideoVC)?.onNewVideo(videoURL);
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
/// Check it the passed media is available using the image picker view controller.
/// e.g. Check for .Camera, .PhotoLibrary
///
	private func imagePickerMediaAvailable(sourceType: UIImagePickerControllerSourceType) -> Bool {
		if let mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(sourceType)
		where UIImagePickerController.isSourceTypeAvailable(sourceType)
		&& mediaTypes.contains(kUTTypeImage as String) {
			return true;
		} else {
			return false;
		}
	}
}
