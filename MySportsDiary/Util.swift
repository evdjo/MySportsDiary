//
//  Util.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 21/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import Photos
import MobileCoreServices
import UIKit
import AVKit
import AVFoundation
import MobileCoreServices

///
/// Gender
///
enum Gender: Int {
	case BOY = 1
	case GIRL = 2
}

///
/// Initial means we need to ask initial questionnaire & age/gender
/// Diary means the user is currently able to record new events
/// Final means the user must answer the final questionnaire and send the data
///
enum ApplicationState: String {
	case Initial = "InitialState"
	case Diary = "DiaryState"
	case Final = "FinalState"
}

///
/// When in the popover for image/video
///
enum mediaType {
	case photo
	case video
}

///
/// Timestamp since epoch
///

internal func timestamp() -> String {
	return "\(NSDate().timeIntervalSince1970 * 1000)";
}

///
/// Alert with the passed message, with single OK button to dismiss the alert.
///
internal func alertWithMessage(sender: UIViewController, title: String) {
	let alertController = UIAlertController(title: title, message: nil, preferredStyle: .Alert);
	let dismissAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil);
	alertController.addAction(dismissAction);
	sender.presentViewController(alertController, animated: true, completion: nil);
}

///
/// Alert with two actions, pass the handlers for each action and the titles for each.
///
internal func binaryChoiceMessage(sender: UIViewController, title: String,
	choice0: String, handler0: ((UIAlertAction) -> Void)?,
	choice1: String, handler1: ((UIAlertAction) -> Void)?) {

		let alertController = UIAlertController(title: title, message: nil, preferredStyle: .Alert);
		let action0 = UIAlertAction(title: choice0, style: .Default, handler: handler0);
		let action1 = UIAlertAction(title: choice1, style: .Default, handler: handler1);
		alertController.addAction(action0);
		alertController.addAction(action1);
		sender.presentViewController(alertController, animated: true, completion: nil);
}

///
/// Check it the passed media is available using the image picker view controller.
/// e.g. Check for .Camera, .PhotoLibrary
///
internal func imagePickerMediaAvailable(sourceType: UIImagePickerControllerSourceType) -> Bool {
	if let mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(sourceType)
	where UIImagePickerController.isSourceTypeAvailable(sourceType)
	&& mediaTypes.contains(kUTTypeImage as String) {
		return true;
	} else {
		return false;
	}
}

///
/// Dispatch a thread to navigate to the settings of this app
///
internal func goToSettings() {
	dispatch_async(dispatch_get_main_queue(), {
		UIApplication.sharedApplication().openURL(
			NSURL(string: UIApplicationOpenSettingsURLString)!);
	})
}

internal func dateString(date: NSDate) -> String {
	let fmt = NSDateFormatter();
	fmt.dateFormat = "dd_MM_yyyy_HH_mm_ss"
	return fmt.stringFromDate(date);
}


