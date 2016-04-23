//
//  UIUtil.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 11/04/2016.
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
/// Alert with the passed message, with single OK button to dismiss the alert.
///
internal func alertWithMessage(sender: UIViewController, title: String) {
	let alertController = UIAlertController(title: title, message: nil, preferredStyle: .Alert);
	let dismissAction = UIAlertAction(title: OK, style: .Cancel, handler: nil);
	alertController.addAction(dismissAction);
	sender.presentViewController(alertController, animated: true, completion: nil);
}

///
/// Alert with the passed message, with single OK button to dismiss the alert.
///
internal func alertWithMessage(sender: UIViewController, title: String, message: String) {
	let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert);
	let dismissAction = UIAlertAction(title: OK, style: .Cancel, handler: nil);
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
/// Dispatch a thread to navigate to the settings of this app
///
internal func goToSettings() {
	let appSettings = NSURL(string: UIApplicationOpenSettingsURLString)!;
	dispatch_async(dispatch_get_main_queue(), {
		print(UIApplication.sharedApplication().openURL(appSettings));
	})
}

///
/// Dispatch time in seconds
///
internal func dispatchTime(sec seconds: Int64) -> dispatch_time_t {
	return dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW),
		seconds * Int64(NSEC_PER_SEC))
}

///
/// UIColor from 0 to 255 values
///
internal func colorRGB(red red: Int, green: Int, blue: Int, alpha: Float) -> UIColor {
	return UIColor(
		colorLiteralRed: Float(red) / 255,
		green: Float(green) / 255,
		blue: Float(blue) / 255,
		alpha: alpha)
}
///
/// The blue color used across the app
///
internal var appBlueColor = colorRGB(red: 151, green: 215, blue: 255, alpha: 1.0);

