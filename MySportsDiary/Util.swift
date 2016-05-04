//
//  Util.swift
//  MyRugbyDiary
//
//  Created by Evdzhan Mustafa on 21/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation
import UIKit
///
/// Gender
///
enum Gender: Int {
	case BOY = 1
	case GIRL = 2
}

///
/// Initial - ask initial questionnaire & age/gender
/// Diary - currently able to record new events
/// Final - must answer the final questionnaire and send the data
/// Epilogue - user has sent the data.
///
enum ApplicationState: String {
    case Initial = "InitialState"
    case Diary = "DiaryState"
    case Final = "FinalState"
    case Epilogue = "EpilogueState"
}

///
/// When in the popover for image/video
///
enum mediaType {
	case photo
	case video
}
///
/// To determine if the shown entry in SingleEntryViewController
/// is New or Existing
///
enum EntryType {
	case New
	case Existing
}

///
/// The entries shown in the table view in the third tab bar
/// sorted used the enum below
///
enum ShownEntries {
	case Today
	case Week
	case Month
}

///
/// Timestamp since epoch
///
internal func timestamp() -> String {
	return "\(NSDate().timeIntervalSince1970 * 1000)";
}

/// to display on screen formatter
internal var screenFormatter: NSDateFormatter {
	let fmt = NSDateFormatter();
	fmt.dateFormat = "dd/MM/yyyy"
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
internal func stringDate(string: String) -> NSDate? {
	return formatter.dateFromString(string);
}

/// Resize an image while preserving it's aspect ratio
internal func aspectFitResizeImageTo(
	wantedWidth wantedWidth: CGFloat,
	image: UIImage)
	-> UIImage
{
	let ratioScale = wantedWidth / image.size.width
	let newHeight = image.size.height * ratioScale
	UIGraphicsBeginImageContext(CGSizeMake(wantedWidth, newHeight))
	image.drawInRect(CGRectMake(0, 0, wantedWidth, newHeight))
	let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
	UIGraphicsEndImageContext()
	
	return resizedImage
}
///
/// Check if the two dates are within 7 days if each other
///
internal func datesAreWithinWeek(
	fromDate: NSDate,
	_ toDate: NSDate)
	-> Bool
{
	let unitFlags = NSCalendarUnit.Day ;
	let comps = NSCalendar.currentCalendar().components(
		unitFlags,
		fromDate: fromDate,
		toDate: toDate,
		options: NSCalendarOptions.init(rawValue: 0))
	
	var days = comps.day;
	if days < 0 {
		days *= -1;
	}
	return days < 7;
}

///
/// Dummy entry with date 'days' before today.
///
internal func dummyEntry(days days: Int) -> Entry {
	let date = NSDate();
	let daysAgo = NSCalendar.currentCalendar().dateByAddingUnit(
			.Day,
		value: -days,
		toDate: date,
		options: NSCalendarOptions(rawValue: 0))!
    
	let randomEntryIndex = Int(arc4random_uniform(UInt32(SKILLS.count)))
	return Entry(
		entry_id: Int64(days),
		skill: SKILLS[randomEntryIndex],
		description: String(days),
		date_time: dateString(daysAgo),
		latitude: 0, longitude: 0)
}

