//
//  UIUtil.swift
//  MyRugbyDiary
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
internal func alertWithMessage(
	sender: UIViewController,
	title: String)
	-> Void
{
	let alertController = UIAlertController(
		title: title,
		message: nil,
		preferredStyle: .Alert);
	
	let dismissAction = UIAlertAction(
		title: OK,
		style: .Cancel,
		handler: nil);
	
	alertController.addAction(dismissAction);
	
	sender.presentViewController(
		alertController,
		animated: true,
		completion: nil);
}

///
/// Alert with the passed message, with single OK button to dismiss the alert.
///
internal func alertWithMessage(
	sender: UIViewController,
	title: String,
	message: String)
	-> Void
{
	let alertController = UIAlertController(title: title, message: message,
		preferredStyle: .Alert);
	let dismissAction = UIAlertAction(title: OK, style: .Cancel, handler: nil);
	alertController.addAction(dismissAction);
	sender.presentViewController(alertController, animated: true,
		completion: nil);
}

///
/// Alert with two actions, pass the handlers
/// for each action and the titles for each.
///
internal func binaryChoiceMessage(
	sender: UIViewController,
	title: String,
	choice0: String,
	handler0: ((UIAlertAction) -> Void)?,
	choice1: String,
	handler1: ((UIAlertAction) -> Void)?)
	-> Void
{
	let alertController = UIAlertController(title: title,
		message: nil, preferredStyle: .Alert);
	
	let action0 = UIAlertAction(title: choice0, style: .Default,
		handler: handler0);
	
	let action1 = UIAlertAction(title: choice1, style: .Default,
		handler: handler1);
	
	alertController.addAction(action0);
	alertController.addAction(action1);
	sender.presentViewController(alertController,
		animated: true, completion: nil);
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
/// Dispatches the passed code after the time specified by delay seconds.
///
internal func executeThis(
	afterDelayInSeconds delay: Double,
	_ code: () -> ())
	-> Void
{
	let when = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW),
		Int64(delay * Double(NSEC_PER_SEC)))
	
	dispatch_after(when, dispatch_get_main_queue(), code);
}

///
/// UIColor from 0 to 255 values
///
internal func colorFromRGB(
	red red: Int,
	green: Int,
	blue: Int,
	alpha: Float)
	-> UIColor
{
	return UIColor(
		colorLiteralRed: Float(red) / 255,
		green: Float(green) / 255,
		blue: Float(blue) / 255,
		alpha: alpha)
}

/// Colors used throuhgout the app
enum Colors {
	case MyBlue
	case Clear
	case White
	case Black
	case MyBlue_2
	case MercuryGray
}

extension Colors {
	static func getColor(colorIndex: Colors) -> UIColor {
		switch colorIndex {
		case .MyBlue: return colorFromRGB(red: 0, green: 110, blue: 255, alpha: 1.0)
		case .Clear: return UIColor.clearColor();
		case .White: return UIColor.whiteColor();
		case .Black: return UIColor.blackColor();
		case .MyBlue_2: return colorFromRGB(red: 135, green: 206, blue: 250, alpha: 1.0)
		case .MercuryGray: return colorFromRGB(red: 230, green: 230, blue: 230, alpha: 1.0);
		}
	}
}

/// short hand functions to setup the buttons throughout the app
func setButton(button: UIButton) {
	button.backgroundColor = Config.buttonsColor;
	button.setBorder(Config.borderWidth, Config.borderColor);
	button.setRadius(Config.buttonsRadius);
	button.setTitleColor(Config.buttonsTextColor, forState: .Normal)
}

/// to set count labels  used in the app
func setCountLabel(label: UILabel) {
	label.backgroundColor = Config.labelColor;
	label.setRadius(Config.labelRadius);
	label.textColor = Config.buttonsTextColor
}

/// to set any segemented controls used in the app
func setSegmentedControl(segControl: UISegmentedControl) {
	segControl.backgroundColor = Config.segControlsBackColor;
	segControl.tintColor = Config.segControlsTintColor;
}

// Mark:-
// Mark: extracted  functions to help with the setting of buttons/labels
extension UIView {
	func setBorder(borderWith: CGFloat, _ borderColor: CGColor) {
		self.layer.borderWidth = borderWith;
		self.layer.borderColor = borderColor;
	}
	
	func setRadius(radius: CGFloat? = nil) {
		self.layer.cornerRadius = radius ?? self.frame.height / 2;
		self.layer.masksToBounds = true;
	}
}

