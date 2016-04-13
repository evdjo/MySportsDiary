//
//  FirstViewController.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 11/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//
import Foundation
import UIKit
import QuartzCore
import MobileCoreServices

class NewEntryDescriptionAndMediaVC: UIViewController,
UIPopoverPresentationControllerDelegate, UITextViewDelegate, MediaCountDelegate {

	private var promptText: String {
		get {
			return "Tell us how rugby helped you to demonstrate " +
				"\(skill.lowercaseString) today."
		}
	}
	var skill: String = "";

	@IBOutlet weak var audioCountLabel: UILabel!
	@IBOutlet weak var videoCountLabel: UILabel!
	@IBOutlet weak var imagesCountLabel: UILabel!;
	@IBOutlet weak var descriptionTextArea: UITextView!
	@IBOutlet weak var tellUsHowLabel: UILabel!

	override func viewDidLoad() {
		super.viewDidLoad();
		descriptionTextArea.delegate = self;
		descriptionTextArea.text = enterText;
		tellUsHowLabel.text = promptText;
	}
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated);
		updateImagesCount();
		updateVideoCount();
		updateAudioCount();
	}

	override func viewWillDisappear(animated: Bool) {
		super.viewWillDisappear(animated);
		if (navigationController?.topViewController != self) {
			self.navigationController?.navigationBarHidden = false;
		}
	}

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		self.view.alpha = 0.20;
		let controller = segue.destinationViewController;

		if segue.identifier == "photoSegue" || segue.identifier == "videoSegue" {
			controller.preferredContentSize = CGSize(width: view.frame.width, height: view.frame.height);
		} else if segue.identifier == "audioSegue" {
			controller.preferredContentSize = CGSize(width: view.frame.width, height: 60);
		}

		if let controller = controller as? MediaContainer {
			controller.mediaCountDelegate = self;
		}

		controller.popoverPresentationController?.delegate = self;
		controller.popoverPresentationController?.sourceRect = (sender as! UIButton).bounds;
		controller.popoverPresentationController?.backgroundColor = blue;
	}

	func popoverPresentationControllerDidDismissPopover(_: UIPopoverPresentationController) {
		self.view.alpha = 1;
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
///
/// Hide the keyboard on done pressed
///
	func textView(textView: UITextView, shouldChangeTextInRange range: NSRange,
		replacementText text: String) -> Bool {
			if text == "\n" {
				textView.resignFirstResponder();
				return false;
			}
			return true;
	}

	func textViewShouldBeginEditing(textView: UITextView) -> Bool {

		if textView.text == enterText {
			textView.text = "";
			textView.textColor = UIColor.blackColor();
		}
		return true;
	}
	func textViewDidEndEditing(textView: UITextView) {
		if textView.text.characters.count == 0 {
			textView.text = enterText;
			textView.textColor = UIColor.lightGrayColor();
		}
	}

	func updateImagesCount() {
		let imagesCount = DataManagerInstance().getImagesCount();
		if imagesCount > 0 {
			imagesCountLabel.text = String(imagesCount);
			imagesCountLabel.hidden = false;
		} else {
			imagesCountLabel.hidden = true;
		}
	}

	func updateVideoCount() {
		if (DataManagerInstance().getTempVideo() != nil) {
			videoCountLabel.text = "1";
			videoCountLabel.hidden = false;
		} else {
			videoCountLabel.text = "0";
			videoCountLabel.hidden = true ;
		}
	}

	func updateAudioCount() {
		if (DataManagerInstance().getTempAudio().exists) {
			audioCountLabel.text = "1";
			audioCountLabel.hidden = false;
		} else {
			audioCountLabel.text = "0";
			audioCountLabel.hidden = true ;
		}
	}

	func adaptivePresentationStyleForPresentationController(controller: UIPresentationController)
		-> UIModalPresentationStyle {
			return .None;
	}
	@IBAction func onAddEntryPressed(sender: AnyObject) {

		let date = dateString(NSDate());

		// let newDir = DataManagerInstance().moveTempImages(toDir: date);
		DataManagerInstance().addNewEntry(
			Entry(entry_id: -1,
				skill: skill,
				description: descriptionTextArea.text ?? "",
				date_time: date,
				latitude: 1.0,
				longitude: 1.0,
				photos: nil,
				audio: nil,
				video: nil))
		self.tabBarController?.selectedIndex = 1;

//        let fromView = self.tabBarController?.selectedViewController!.view;
//        let toView = self.tabBarController?.viewControllers![2].view;
//
//        UIView.transitionFromView(
//            fromView!, toView: toView!, duration: 0.56,
//            options: .TransitionFlipFromRight,
//            completion: { (finished) in
//                if (finished) {
//                    self.navigationController?.popViewControllerAnimated(false)
//                    self.tabBarController?.selectedIndex = 2;
//                }
//        });
	}
}

protocol MediaCountDelegate {
	func onCountChange(sender: UIViewController);
}

protocol MediaContainer: class {
	var mediaCountDelegate: MediaCountDelegate? { get set }
}
