//
//  Util.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 21/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation

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

internal func stringOptionalEqual(lhs: String?, rhs: String?) -> Bool {
	guard (lhs.dynamicType == rhs.dynamicType) else {
		return false;
	}
	if lhs == nil && rhs == nil { return true }

	if nil != lhs && nil != rhs {
		return lhs == rhs;
	} else {
		return false;
	}
}

internal var screenFormatter: NSDateFormatter {
	let fmt = NSDateFormatter();
	fmt.dateFormat = "dd/MM/yyyy HH:mm:ss"
	return fmt
}

/// to be used when shown on screen
internal func screenDateString(date: NSDate) -> String {
	return screenFormatter.stringFromDate(date);
}

/// DB formatter
internal var formatter: NSDateFormatter {
	let fmt = NSDateFormatter();
	fmt.dateFormat = "dd-MM-yyyy-HH-mm-ss-SSSS"
	return fmt
}

/// to be used when put to DB
internal func dateString(date: NSDate) -> String {
	return formatter.stringFromDate(date);
}

// to be used when read from DB
internal func stringDate(string: String) -> NSDate {
	return formatter.dateFromString(string)!;
}

/// LOST AND FOUND

///
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
