//
//  VideoPickerVC.swift
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

class MediaPopoverVideoVC: UIViewController, MediaPopover {
	// Delegate stuff
	var delegate: MediaPopoverDataDelegate?;

	private lazy var mediaPicker: MediaPicker = MediaPicker(parentVC: self, mediaType: kUTTypeMovie as String);
	private var avPlayerViewController: AVPlayerViewController?;
	private var videoToPlayURL: NSURL? = nil;
	@IBOutlet weak var videoContainer: UIView!
	@IBOutlet weak var pickFromSourceButtons: UIStackView!
	@IBOutlet weak var deleteVideoButton: UIButton!

	@IBAction func onUseCameraButtonPressed(sender: AnyObject) {
		mediaPicker.pickUsingCamera();
	}
	@IBAction func onPhotosLibraryButtonPressed(sender: AnyObject) {
		mediaPicker.pickFromLibrary();
	}

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated);
		// dispatch_async(dispatch_get_main_queue(), {
		self.videoToPlayURL = delegate?.video;
		self.setUp();
		// });
	}

	func onNewVideo(videoURL: NSURL) {
		videoToPlayURL = videoURL;
		delegate?.video = videoURL;
		setUp();
	}

	private func setUp() {
		if let url = videoToPlayURL {
			if avPlayerViewController == nil {
				self.avPlayerViewController = AVPlayerViewController()
			}
			self.addChildViewController(avPlayerViewController!)
			self.videoContainer.addSubview(avPlayerViewController!.view)
			self.avPlayerViewController!.view.frame = self.videoContainer.frame
			self.avPlayerViewController!.player = AVPlayer(URL: url)
			self.videoContainer.setNeedsDisplay();
			self.avPlayerViewController!.view.setNeedsDisplay();
			self.deleteVideoButton.enabled = true;
			self.deleteVideoButton.alpha = 1.0;
		} else {
			self.deleteVideoButton.enabled = false;
			self.deleteVideoButton.alpha = 0.5;
		}
	}
	@IBAction func onDeletePressed(sender: AnyObject) {
		guard videoToPlayURL != nil else { return }

		let controller = UIAlertController(title: DELETE_THE_VIDEO,
			message: nil, preferredStyle: .ActionSheet)

		let yesAction = UIAlertAction(title: YES, style: .Destructive, handler: {
			action in
			self.avPlayerViewController?.player = nil
			self.avPlayerViewController?.view.removeFromSuperview()
			self.avPlayerViewController?.removeFromParentViewController()
			self.delegate?.video = nil;
			self.videoToPlayURL = nil;
			self.setUp();
		});
		controller.addAction(yesAction)
		controller.addAction(UIAlertAction(title: NO, style: .Cancel, handler: nil))
		presentViewController(controller, animated: true, completion: nil)
	}
}
