//
//  EntrySecondScreen.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 11/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//
import Foundation
import UIKit
import QuartzCore
import MobileCoreServices

class EntrySecondScreen: UIViewController, MediaCountDelegate {

	@IBOutlet weak var audioCountLabel: UILabel!
	@IBOutlet weak var videoCountLabel: UILabel!
	@IBOutlet weak var imagesCountLabel: UILabel!;
	@IBOutlet weak var descriptionTextArea: UITextView!
	@IBOutlet weak var tellUsHowLabel: UILabel!
	@IBOutlet weak var doneButton: UIButton!

	var topLabelText: String?;
	var skill: String = "";
	var entryDescription: String?;

	var mediaDelegate: MediaDelegate?;
	private var textDelegate: DescriptionTextDelegate?;
	private var popoverDelegate: MediaPopoverDelegate?;

	override func viewDidLoad() {
		super.viewDidLoad();
		textDelegate = DescriptionTextDelegate();
		descriptionTextArea.delegate = textDelegate;
		if let entryDescription = entryDescription {
			descriptionTextArea.text = entryDescription;
		} else {
			descriptionTextArea.text = enterText;
		}
		tellUsHowLabel.text = topLabelText;
	}
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated);
		navigationController?.navigationBarHidden = false;

		if mediaDelegate is NewEntryMediaDelegate {
			doneButton.setTitle("Add entry", forState: .Normal)
		} else {
			doneButton.setTitle("Done editing", forState: .Normal)
			doneButton.backgroundColor = UIColor.darkGrayColor()
		}

		updateImagesCount();
		updateVideoCount();
		updateAudioCount();
	}

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

		self.view.alpha = 0.20;
		let dest = segue.destinationViewController;

		var size = CGSize(width: view.frame.width, height: view.frame.height);
		if segue.identifier! == "audioSegue" { size.height = 60; }
		dest.preferredContentSize = size;

		switch (segue.identifier!) {
		case "audioSegue":
			(dest as! AudioRecorderVC).delegate = mediaDelegate;
		case "videoSegue":
			(dest as! VideoPopoverVC).delegate = mediaDelegate;
		case "photoSegue":
			(dest as! ImagesPopoverVC).delegate = mediaDelegate;
		default: break
			// no op;
		}

		if let vc = dest as? MediaContainer { vc.mediaCountDelegate = self; }
		if popoverDelegate == nil {
			popoverDelegate = MediaPopoverDelegate(originVC: self)
		}
		dest.popoverPresentationController?.delegate = popoverDelegate;
		dest.popoverPresentationController?.sourceRect = (sender as! UIButton).bounds;
		dest.popoverPresentationController?.backgroundColor = blue;
	}

	func onCountChange(sender: UIViewController) {
		if sender is ImagesPopoverVC {
			updateImagesCount();
		} else if sender is VideoPopoverVC {
			updateVideoCount();
		} else if sender is AudioRecorderVC {
			updateAudioCount();
		}
	}

	func updateImagesCount() {
//		let imagesCount = DataManagerInstance().getImagesCount();
//		if imagesCount > 0 {
//			imagesCountLabel.text = String(imagesCount);
//			imagesCountLabel.hidden = false;
//		} else {
//			imagesCountLabel.hidden = true;
//		}
	}

	func updateVideoCount() {
//		if (DataManagerInstance().getTempVideo() != nil) {
//			videoCountLabel.text = "1";
//			videoCountLabel.hidden = false;
//		} else {
//			videoCountLabel.text = "0";
//			videoCountLabel.hidden = true ;
//		}
	}

	func updateAudioCount() {
//		if (DataManagerInstance().getTempAudio() != nil) {
//			audioCountLabel.text = "1";
//			audioCountLabel.hidden = false;
//		} else {
//			audioCountLabel.text = "0";
//			audioCountLabel.hidden = true ;
//		}
	}

	@IBAction func onAddEntryPressed(sender: AnyObject) {

		if let del = mediaDelegate as? NewEntryMediaDelegate {
			let date = dateString(NSDate());
			let dir = fileURLUnderParent(file: date, parent: ENTRIES_DIR_URL);
			del.copyOver(destination: dir);
			DataManagerInstance().addNewEntry(
				Entry(entry_id: -1,
					skill: skill,
					description: descriptionTextArea.text ?? "",
					date_time: date,
					latitude: 1.0,
					longitude: 1.0,
					photos: nil, audio: nil, video: nil))

			self.tabBarController?.selectedIndex = 1;
		} else {
			self.navigationController?.popToRootViewControllerAnimated(false)
			// dismissViewControllerAnimated(false, completion: nil)
		}
	}
}

protocol MediaCountDelegate {
	func onCountChange(sender: UIViewController);
}

protocol MediaContainer: class {
	var mediaCountDelegate: MediaCountDelegate? { get set }
}
