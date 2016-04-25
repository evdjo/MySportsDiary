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

class MediaPopoverImagesVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MediaPopover {
// Delegate stuff
	var delegate: MediaPopoverDataDelegate?;
// Image stuff
	private var picker: MediaPicker?;
	private var images: [UIImage]?; /// The images shown in the image view
	private var imageIndex = 0; /// Which image showing currently
	
	@IBOutlet weak var deleteImageButton: UIButton!
	@IBOutlet weak var imageIndexLabel: UILabel!
	@IBOutlet weak var navigationViews: UIView!
	@IBOutlet weak var currentlyShownImage: UIImageView!
	@IBOutlet weak var noImageLabel: UILabel!
	
	///
	/// Load any temp images, and show the first
	///
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated);
		// dispatch_async(dispatch_get_main_queue(), {
		self.picker = MediaPicker(parentVC: self, mediaType: kUTTypeImage as String)
		self.loadTempImages();
		self.setCurrentImage();
		// });
	}
	
	@IBAction func onCameraButtonPressed(sender: AnyObject) {
		picker?.pickUsingCamera();
	}
	@IBAction func onPhotosLibraryButtonPressed(sender: AnyObject) {
		picker?.pickFromLibrary();
	}
	@IBAction func onDeleteButtonPressed(sender: AnyObject) {
		if let images = self.images where images.count > imageIndex {
			let controller = UIAlertController(title: DELETE_THE_PHOTO,
				message: nil, preferredStyle: .ActionSheet)
			
			let yesAction = UIAlertAction(title: YES, style: .Destructive, handler: {
				action in
				self.images!.removeAtIndex(self.imageIndex);
				self.delegate?.removeImage(self.imageIndex);
				self.imageIndex = max(0, self.imageIndex - 1);
				self.setCurrentImage();
			});
			controller.addAction(yesAction)
			controller.addAction(UIAlertAction(title: NO, style: .Cancel, handler: nil))
			presentViewController(controller, animated: true, completion: nil)
		}
	}
	
	@IBAction func onPreviousButtonPressed(sender: AnyObject) {
		if let images = images where images.count > 1 {
			imageIndex = imageIndex - 1 < 0 ? images.count - 1: imageIndex - 1;
			imageIndexLabel.text = "\(imageIndex + 1) / \(images.count) "
			setCurrentImage();
		}
	}
	@IBAction func onNextButtonPressed(sender: AnyObject) {
		if let images = images where images.count > 1 {
			imageIndex = imageIndex + 1 < images.count ? imageIndex + 1: 0;
			imageIndexLabel.text = "\(imageIndex + 1) / \(images.count) "
			setCurrentImage();
		}
	}
	
///
/// If we have images in the images array, set the one at position image index to our image view
/// else hide the image view, along with the controls assosicated with it
///
	private func setCurrentImage() {
		if let images = images where images.count > imageIndex && 0 <= imageIndex {
			currentlyShownImage.image = images[imageIndex];
			noImageLabel.hidden = true;
			navigationViews.hidden = false;
			imageIndexLabel.hidden = false;
			imageIndexLabel.text = "\(imageIndex + 1) / \(images.count) "
			deleteImageButton.enabled = true;
			deleteImageButton.alpha = 1.0;
		} else {
			currentlyShownImage.image = nil;
			noImageLabel.hidden = false;
			navigationViews.hidden = true;
			imageIndexLabel.hidden = true;
			deleteImageButton.enabled = false;
			deleteImageButton.alpha = 0.5;
		}
	}
///
/// Load any temp images
///
	func loadTempImages() {
		guard nil == images else { return }
		images = delegate?.images();
	}
	
	func onNewImage(image: UIImage) {
		let resizedImage = aspectFitResizeImageTo(wantedWidth: 480, image: image)
		if nil == images {
			images = Array<UIImage>();
			imageIndex = 0 ;
		}
		images!.append(resizedImage);
		imageIndex = images!.count - 1;
		delegate?.newImage(resizedImage);
		setCurrentImage();
	}
}
