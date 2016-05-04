//
//  SingleEntryViewerVC.swift
//  MyRugbyDiary
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
	
/// The presented view controller if any
	private var presentationVC: UIPopoverPresentationController?;
    
    
///
/// just set the text delegate on load
///
	override func viewDidLoad() {
		super.viewDidLoad();
		textDelegate = DescriptionTextDelegate();
		descriptionTextArea.delegate = textDelegate;
		setButton(doneButton);
		setCountLabel(voiceCountLabel);
		setCountLabel(videoCountLabel);
		setCountLabel(imagesCountLabel);
		descriptionTextArea.setRadius(5);
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
///
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated);
		navigationController?.navigationBarHidden = false;
		
		guard entryType != nil else { print("entry type not set"); return }
		
		switch (entryType!) {
		case .New:
			topLabel.text = "\(NEW_ENTRY_TEXT_1) \(skill.lowercaseString) \(NEW_ENTRY_TEXT_2)";
			descriptionTextArea.text = ENTER_TEXT;
			doneButton.setTitle(DONE, forState: .Normal);
			doneButton.backgroundColor = Config.buttonsColor;
			self.mediaDelegate = MediaPopoverDataDelegateNewEntry();
			locationGetter = GPSLocationGetter(parentVC: self)
			addVoiceLabel.text = ADD_VOICE
			addPhotoLabel.text = ADD_PHOTO
			addVideoLabel.text = ADD_VIDEO
			
		case .Existing:
			guard entry != nil else { print("entry found to be nil"); return }
			topLabel.text = entry!.skill;
			descriptionTextArea.text = entry!.description;
			doneButton.setTitle(DONE_EDITING, forState: .Normal);
			doneButton.backgroundColor = Config.cellHighlightedColor;
			self.mediaDelegate = MediaPopoverDataDelegateExistingEntry(entry: entry!);
			addVoiceLabel.text = ADDED_VOICE
			addPhotoLabel.text = ADDED_PHOTO
			addVideoLabel.text = ADDED_VIDEO
		}
		
		if descriptionTextArea.text == ENTER_TEXT {
			descriptionTextArea.textColor = UIColor.lightGrayColor();
		} else {
			descriptionTextArea.textColor = UIColor.blackColor();
		}
		
		updateAudioCountLabel();
		updateImagesCountLabel();
		updateVideoCountLabel();
	}
    
///
/// Update the small label indicating the count of audio files.
/// Currently, since only 1 audio is allowed, the possible values are 0 or 1
///
    func updateAudioCountLabel() {
		voiceCountLabel.text = mediaDelegate.audio == nil ? "0" : "1";
		voiceCountLabel.hidden = mediaDelegate.audio == nil;
	}
    
///
/// Update the small label indicating the count of video files.
/// Currently, since only 1 video is allowed, the possible values are 0 or 1
///
    func updateImagesCountLabel() {
		let imagesCount = mediaDelegate.getImagesCount()
		imagesCountLabel.text = String(imagesCount);
		imagesCountLabel.hidden = 0 == imagesCount;
	}
    
///
/// Update the small label indicating the count of images.
///
    func updateVideoCountLabel() {
		videoCountLabel.text = mediaDelegate.video == nil ? "0" : "1";
		videoCountLabel.hidden = mediaDelegate.video == nil;
	}
    
///
/// Save the description text field if this is existing entry.
///
	override func viewWillDisappear(animated: Bool) {
		super.viewWillDisappear(animated);
		if let entry = entry, let entryType = entryType where entryType == .Existing {
			DataManagerInstance().updateEntryWithID(id: entry.entry_id,
				newDescr: descriptionTextArea.text)
		}
		locationGetter?.stop();
		presentationVC?.presentedViewController
			.dismissViewControllerAnimated(false, completion: nil);
        self.navigationController?.popToRootViewControllerAnimated(false);

	}
    
///
/// Set the presentaion view controller
/// If this is the audio popover, set its height to 60
/// Set the delegate of the media popover to be the mediaDelegate,
/// which resides in this class as property
///
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		guard nil != segue.identifier else { print("Tried to segue without identifier"); return; }
		guard sender is UIButton else { print("Didn't expect to segue from non button sender"); return; }
		
		let destination = segue.destinationViewController;
		
		if var mediaPopover = destination as? MediaPopover {
			mediaPopover.delegate = self.mediaDelegate;
		}
		let height = segue.identifier! == "audioSegue" ? 60 : view.frame.height ;
		destination.preferredContentSize = CGSize(width: view.frame.width, height: height);
		
		presentationVC = destination.popoverPresentationController
		presentationVC?.delegate = self;
		presentationVC?.sourceRect = (sender as! UIButton).bounds;
		presentationVC?.backgroundColor = Config.popoverBackgroundColor;
		
		self.view.alpha = 0.20;
	}
    
///
/// When we either add a new entry or save existing one.
///
	@IBAction func onAddEntryPressed(_: AnyObject) {
		switch (entryType!) {
		case .New:
			addNewEntry();
		case .Existing:
			onExistingSave();
		}
	}
    
///
/// Just popback to the entries view controller
///
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
		
		/// set the new entry flag to true
		let vc = self.tabBarController?.viewControllers?[2]
            as? UINavigationController;
        
		let entriesVC = vc?.viewControllers.last as? AllEntriesViewerVC;
		entriesVC?.newEntryAdded = true;
		
		self.tabBarController?.selectedIndex = 2;
	}
    
///
/// Change the alpha back to 1.0
/// Update the count on the small labels.
///
	func popoverPresentationControllerDidDismissPopover(
        _: UIPopoverPresentationController)
        -> Void
    {
		self.view.alpha = 1.0;
		updateAudioCountLabel();
		updateImagesCountLabel();
		updateVideoCountLabel();
	}
    
///
/// To back the popovers work.
///
	func adaptivePresentationStyleForPresentationController(
        _: UIPresentationController)
        -> UIModalPresentationStyle
    {
		return .None;
	}
    
///
/// So that the keyboard closes on when the user taps in the background
///
	@IBAction func onBackgroundTap(_: UITapGestureRecognizer) {
		descriptionTextArea.resignFirstResponder();
	}
}
