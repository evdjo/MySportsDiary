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

	@IBOutlet weak var audioCountLabel: UILabel!
	@IBOutlet weak var videoCountLabel: UILabel!
	@IBOutlet weak var imagesCountLabel: UILabel!;
	@IBOutlet weak var descriptionTextArea: UITextView!
	@IBOutlet weak var topLabel: UILabel!
	@IBOutlet weak var doneButton: UIButton!

	internal var entry: Entry?;
	internal var entryType: EntryType?;
	internal var skill: String = "";

	internal var mediaDelegate: MediaPopoverDataDelegate!;
	private var textDelegate: DescriptionTextDelegate?;

	override func viewDidLoad() {
		super.viewDidLoad();
		textDelegate = DescriptionTextDelegate();
		descriptionTextArea.delegate = textDelegate;
	}
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated);
		navigationController?.navigationBarHidden = false;

		guard entryType != nil else { print("entry type not set"); return }

		switch (entryType!) {
		case .New:
			topLabel.text = "Tell us why rugby has helped you demonstrate \(skill.lowercaseString) today:";
			descriptionTextArea.text = enterText;
			descriptionTextArea.textColor = UIColor.lightGrayColor();
			doneButton.setTitle("Add entry", forState: .Normal);
			doneButton.backgroundColor = colorRGB(red: 151, green: 215, blue: 255, alpha: 1);
			self.mediaDelegate = MediaPopoverDataDelegateNewEntry();

		case .Existing:
			guard entry != nil else { print("entry found to be nil"); return }
			topLabel.text = entry!.skill;
			descriptionTextArea.text = entry!.description;
			descriptionTextArea.textColor = UIColor.blackColor();
			doneButton.setTitle("Done editing", forState: .Normal);
			doneButton.backgroundColor = colorRGB(red: 151, green: 215, blue: 255, alpha: 1);
			self.mediaDelegate = MediaPopoverDataDelegateExistingEntry(entry: entry!);
		}
	}

	override func viewWillDisappear(animated: Bool) {
		super.viewWillDisappear(animated);
		if let entry = entry, let entryType = entryType where entryType == .Existing {
			DataManagerInstance().updateEntryWithID(id: entry.entry_id, newDescr: descriptionTextArea.text)
		}
	}

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		let dest = segue.destinationViewController;
		if var mediaVC = dest as? MediaPopover {
			mediaVC.delegate = self.mediaDelegate;
		}
		var size = CGSize(width: view.frame.width, height: view.frame.height);
		if segue.identifier! == "audioSegue" { size.height = 60; }
		dest.preferredContentSize = size;
		dest.popoverPresentationController?.delegate = self;
		dest.popoverPresentationController?.sourceRect = (sender as! UIButton).bounds;
		dest.popoverPresentationController?.backgroundColor = blue;
		self.view.alpha = 0.20;
	}
	private func setDelegate(dest: UIViewController) {
	}

	@IBAction func onAddEntryPressed(sender: AnyObject) {
		switch (entryType!) {
		case .New:
			addNewEntry();
		case .Existing:
			onExistingSave();
		}
	}

	private func onExistingSave() {
		self.navigationController?.popToRootViewControllerAnimated(false);
	}
	private func addNewEntry() {
		let del = mediaDelegate as! MediaPopoverDataDelegateNewEntry
		let date = dateString(NSDate());
		let dir = fileURLUnderParent(file: date, parent: ENTRIES_DIR_URL);
		del.move(destination: dir);
		DataManagerInstance().addNewEntry(
			Entry(entry_id: -1,
				skill: skill,
				description: descriptionTextArea.text ?? "",
				date_time: date,
				latitude: 1.0,
				longitude: 1.0)
		)

		self.tabBarController?.selectedIndex = 1;
	}

	func popoverPresentationControllerDidDismissPopover(controller:
			UIPopoverPresentationController) {
				self.view.alpha = 1.0;
	}
	func adaptivePresentationStyleForPresentationController(
		_: UIPresentationController) -> UIModalPresentationStyle {
			return .None;
	}
}
