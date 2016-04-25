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
import QuartzCore

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
internal func colorFromRGB(red red: Int, green: Int, blue: Int, alpha: Float) -> UIColor {
	return UIColor(
		colorLiteralRed: Float(red) / 255,
		green: Float(green) / 255,
		blue: Float(blue) / 255,
		alpha: alpha)
}

enum ColorIndex {
	case MyBlue
	case Background
	case Black
	case Clear
	case White
	case Cyan
	case HalfMyBlue
}
internal func getColor(colorIndex: ColorIndex) -> UIColor {
	switch colorIndex {
	case .MyBlue: return colorFromRGB(red: 11, green: 106, blue: 255, alpha: 1.0)
	case .Background: return colorFromRGB(red: 233, green: 233, blue: 233, alpha: 1.0)
	case .Black: return UIColor.blackColor();
	case .Clear: return UIColor.clearColor();
	case .White: return UIColor.whiteColor();
	case .Cyan: return UIColor.cyanColor();
	case .HalfMyBlue: return colorFromRGB(red: 22, green: 156, blue: 175, alpha: 1.0)
	}
}

internal func setButton(button: UIButton) {
	button.backgroundColor = Config.buttonsColor;
	button.__setBorder(Config.borderWidth, Config.borderColor);
	button.__setRadius(Config.buttonsRadius);
	button.setTitleColor(Config.buttonsTextColor, forState: .Normal)
}
internal func setCountLabel(label: UILabel) {
	label.backgroundColor = Config.labelColor;
	label.__setRadius(Config.labelRadius);
	label.textColor = Config.buttonsTextColor
}

internal func setSegmentedControl(segControl: UISegmentedControl) {
	segControl.backgroundColor = Config.segControlsBackColor;
	segControl.tintColor = Config.segControlsTintColor;
}

// Mark:-
// Mark: extracted  functions to help with the setting of buttons/labels
extension UIView {
	func __setBorder(borderWith: CGFloat, _ borderColor: CGColor) {
		self.layer.borderWidth = borderWith;
		self.layer.borderColor = borderColor;
	}
	func __setRadius(radius: CGFloat) {
		self.layer.cornerRadius = radius;
		self.layer.masksToBounds = true;
	}
}

