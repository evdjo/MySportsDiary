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

class EntrySecondScreen: UIViewController, MediaCountDelegate,
AudioRecorderDelegate, ImagesPopoverDelegate, VideoPopoverDelegate {
	@IBOutlet weak var audioCountLabel: UILabel!
	@IBOutlet weak var videoCountLabel: UILabel!
	@IBOutlet weak var imagesCountLabel: UILabel!;
	@IBOutlet weak var descriptionTextArea: UITextView!
	@IBOutlet weak var tellUsHowLabel: UILabel!

	func newImage(image: UIImage) -> Void { DataManagerInstance().saveTempImage(image); }
	func images() -> [UIImage]? { return DataManagerInstance().getTempImages(); }
	func removeImage(index: Int) -> Void { DataManagerInstance().removeTempImage(index); }

	var video: NSURL? {
		set { DataManagerInstance().setTempVideo(newValue); }
		get { return DataManagerInstance().getTempVideo(); }
	}

	var audio: NSURL? {
		set { DataManagerInstance().setTempAudio(newValue); }
		get { return DataManagerInstance().getTempAudio(); }
	}

	var promptText: String!;
	var skill: String = "";
	private var textDelegate: DescriptionTextDelegate?;
	private var popoverDelegate: MediaPopoverDelegate?;

	override func viewDidLoad() {
		super.viewDidLoad();
		textDelegate = DescriptionTextDelegate();
		descriptionTextArea.delegate = textDelegate;
		descriptionTextArea.text = enterText;
		tellUsHowLabel.text = promptText;
	}
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated);
		navigationController?.navigationBarHidden = false;
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
			(dest as! AudioRecorderVC).delegate = self;
		case "videoSegue":
			(dest as! VideoPopoverVC).delegate = self;
		case "photoSegue":
			(dest as! ImagesPopoverVC).delegate = self;
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
		if (DataManagerInstance().getTempAudio() != nil) {
			audioCountLabel.text = "1";
			audioCountLabel.hidden = false;
		} else {
			audioCountLabel.text = "0";
			audioCountLabel.hidden = true ;
		}
	}

	@IBAction func onAddEntryPressed(sender: AnyObject) {
		let date = dateString(NSDate());
		DataManagerInstance().addNewEntry(
			Entry(entry_id: -1, skill: skill,
				description: descriptionTextArea.text ?? "",
				date_time: date, latitude: 1.0, longitude: 1.0,
				photos: nil, audio: nil, video: nil))
		self.tabBarController?.selectedIndex = 1;
	}
}

protocol MediaCountDelegate {
	func onCountChange(sender: UIViewController);
}

protocol MediaContainer: class {
	var mediaCountDelegate: MediaCountDelegate? { get set }
}
