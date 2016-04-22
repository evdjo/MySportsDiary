//
//  SingleEntryViewerVC.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 11/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//
import Foundation
import UIKit
import QuartzCore
import MobileCoreServices

class SingleEntryViewerVC: UIViewController, UIPopoverPresentationControllerDelegate {
// UI elements
	@IBOutlet weak var voiceCountLabel: UILabel!
	@IBOutlet weak var videoCountLabel: UILabel!
	@IBOutlet weak var imagesCountLabel: UILabel!

	@IBOutlet weak var addVoiceLabel: UILabel!
	@IBOutlet weak var addPhotoLabel: UILabel!
	@IBOutlet weak var addVideoLabel: UILabel!

	@IBOutlet weak var descriptionTextArea: UITextView!
	@IBOutlet weak var topLabel: UILabel!
	@IBOutlet weak var doneButton: UIButton!

///The entry if this is an existing entry
	internal var entry: Entry?;

/// Is this a new entry or an existing one ?
	internal var entryType: EntryType?;

/// The skill chosen, if this is a new entry
	internal var skill: String = "";

/// The delegate delegate that is responsible for where the media is saved/loaded from
	internal var mediaDelegate: MediaPopoverDataDelegate!;

/// Delegate for the text view
	private var textDelegate: DescriptionTextDelegate?;

/// GPS Location getter
	private var locationGetter: GPSLocationGetter?;

/// just set the text delegate on load
	override func viewDidLoad() {
		super.viewDidLoad();
		textDelegate = DescriptionTextDelegate();
		descriptionTextArea.delegate = textDelegate;
	}

///
/// Hide the navigation bar.
///
/// Set the top label's text.
///
/// Load the description for the field if this is existing entry.
///
/// Set the color of the button at the bottom depending
/// on if this is existing entry or newly added one.
///
/// Set the appropriate delegate for the data to use by the media pickers.
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated);
		navigationController?.navigationBarHidden = false;

		guard entryType != nil else { print("entry type not set"); return }

		switch (entryType!) {
		case .New:
			topLabel.text = "\(NEW_ENTRY_TEXT_1) \(skill.lowercaseString) \(NEW_ENTRY_TEXT_2)";
			// "Tell us why rugby has helped you demonstrate \(skill.lowercaseString) today:";
			descriptionTextArea.text = ENTER_TEXT;
			doneButton.setTitle(DONE, forState: .Normal);
			doneButton.backgroundColor = colorRGB(red: 151, green: 215, blue: 255, alpha: 1);
			self.mediaDelegate = MediaPopoverDataDelegateNewEntry();
			locationGetter = GPSLocationGetter(parentVC: self)
			addVoiceLabel.text = ADD_VOICE
			addPhotoLabel.text = ADD_PHOTO
			addVideoLabel.text = ADD_VIDEO

		case .Existing:
			guard entry != nil else { print("entry found to be nil"); return }
			topLabel.text = entry!.skill;
			descriptionTextArea.text = entry!.description;
			if entry!.description == ENTER_TEXT {
				descriptionTextArea.textColor = UIColor.lightGrayColor();
			}
			doneButton.setTitle(DONE, forState: .Normal);
			doneButton.backgroundColor = colorRGB(red: 151, green: 151, blue: 255, alpha: 1);
			self.mediaDelegate = MediaPopoverDataDelegateExistingEntry(entry: entry!);
			addVoiceLabel.text = ADDED_VOICE
			addPhotoLabel.text = ADDED_PHOTO
			addVideoLabel.text = ADDED_VIDEO
		}

		updateAudioCountLabel();
		updateImagesCountLabel();
		updateVideoCountLabel();
	}

/// Update the small label indicating the count of audio files.
/// Currently, since only 1 audio is allowed, the possible values are 0 or 1
	func updateAudioCountLabel() {
		voiceCountLabel.text = mediaDelegate.audio == nil ? "0" : "1";
		voiceCountLabel.hidden = mediaDelegate.audio == nil;
	}

/// Update the small label indicating the count of video files.
/// Currently, since only 1 video is allowed, the possible values are 0 or 1
	func updateImagesCountLabel() {
		let imagesCount = mediaDelegate.getImagesCount()
		imagesCountLabel.text = String(imagesCount);
		imagesCountLabel.hidden = 0 == imagesCount;
	}

/// Update the small label indicating the count of images.
	func updateVideoCountLabel() {
		videoCountLabel.text = mediaDelegate.video == nil ? "0" : "1";
		videoCountLabel.hidden = mediaDelegate.video == nil;
	}

/// Save the description text field if this is existing entry.
	override func viewWillDisappear(animated: Bool) {
		super.viewWillDisappear(animated);
		if let entry = entry, let entryType = entryType where entryType == .Existing {
			DataManagerInstance().updateEntryWithID(id: entry.entry_id,
				newDescr: descriptionTextArea.text)
		}
		self.navigationController?.popToRootViewControllerAnimated(false);

		locationGetter?.stop();
	}

/// Set the presentaion view controller
/// If this is the audio popover, set its height to 60
/// Set the delegate of the media popover to be the mediaDelegate,
/// which resides in this class as property
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		let dest = segue.destinationViewController;
		if var mediaVC = dest as? MediaPopover {
			mediaVC.delegate = self.mediaDelegate;
		}
		var size = CGSize(width: view.frame.width, height: view.frame.height);
		if segue.identifier! == "audioSegue" { size.height = 60; }
		dest.preferredContentSize = size;
		dest.popoverPresentationController?.delegate = self;
		if let button = sender as? UIButton {
			dest.popoverPresentationController?.sourceRect = button.bounds;
		}
		dest.popoverPresentationController?.backgroundColor = appBlueColor;
		self.view.alpha = 0.20;
	}
/// When we either add a new entry or save existing one.
	@IBAction func onAddEntryPressed(_: AnyObject) {
		switch (entryType!) {
		case .New:
			addNewEntry();
		case .Existing:
			onExistingSave();
		}
	}
/// Just popback to the entries view controller
	private func onExistingSave() {
		self.navigationController?.popToRootViewControllerAnimated(false);
	}

/// When this is a new entry, save all the details added so far,
/// add a new entry in the database, and move the temp media folder,
/// to the entries folder.
/// That is the folder in Library/Caches/temp_media
/// goes to Library/entries/[datetimestamp here]
	private func addNewEntry() {
 		let date = dateString(NSDate());
        let loc = locationGetter?.getLocation();
		let lat = loc?.coordinate.latitude ?? 0.0;
		let lon = loc?.coordinate.longitude ?? 0.0;       

		DataManagerInstance().addNewEntry(
			Entry(entry_id: -1,
				skill: skill,
				description: descriptionTextArea.text ?? "",
				date_time: date,
				latitude: lat,
				longitude: lon)
		)

		self.tabBarController?.selectedIndex = 2;
	}

/// Change the alpha back to 1.0
/// Update the count on the small labels.
	func popoverPresentationControllerDidDismissPopover(_: UIPopoverPresentationController) {
		self.view.alpha = 1.0;
		updateAudioCountLabel();
		updateImagesCountLabel();
		updateVideoCountLabel();
	}

/// To back the popovers work.
	func adaptivePresentationStyleForPresentationController(_: UIPresentationController) -> UIModalPresentationStyle {
		return .None;
	}

/// So that the keyboard closes on when the user taps in the background
	@IBAction func onBackgroundTap(_: UITapGestureRecognizer) {
		descriptionTextArea.resignFirstResponder();
	}
}
