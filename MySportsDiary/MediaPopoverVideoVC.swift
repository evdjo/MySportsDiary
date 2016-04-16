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
		self.setUpPlayer();
		// });
	}

	func onNewVideo(videoURL: NSURL) {
		videoToPlayURL = videoURL;
		delegate?.video = videoURL;
	}

	private func setUpPlayer() {
		if let url = videoToPlayURL {
			if avPlayerViewController == nil {
				avPlayerViewController = AVPlayerViewController()
				self.addChildViewController(avPlayerViewController!)
				self.videoContainer.addSubview(avPlayerViewController!.view)
				avPlayerViewController!.view.frame = self.videoContainer.frame
			}
			avPlayerViewController!.player = AVPlayer(URL: url)
		}
	}
	@IBAction func onDeletePressed(sender: AnyObject) {
		guard videoToPlayURL != nil else { return }

		let controller = UIAlertController(title: deleteTheVideoText,
			message: nil, preferredStyle: .ActionSheet)

		let yesAction = UIAlertAction(title: yes, style: .Destructive, handler: {
			action in
			self.avPlayerViewController?.player = nil
			self.avPlayerViewController?.view.removeFromSuperview()
			self.avPlayerViewController?.removeFromParentViewController()
			self.delegate?.video = nil;
			self.videoToPlayURL = nil;
		});
		controller.addAction(yesAction)
		controller.addAction(UIAlertAction(title: no, style: .Cancel, handler: nil))
		presentViewController(controller, animated: true, completion: nil)
	}
}
