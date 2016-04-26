//
//  Config.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 22/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation
import UIKit

class Config {
	// MARK:-
	// MARK: The duration of the diary. For testing set this to 2-3 minutes.
	static var DiaryPeriod: Int = 60;
	static var DiaryPeriodUnit: NSCalendarUnit = .Minute
	
	// Mark:-
	// Mark: The views's border radius and color
	static var borderWidth: CGFloat { return 0.5 }
	static var borderColor: CGColor { return Colors.getColor(.Black).CGColor }
	
	// MARK:-
	// MARK: The small bubble labels settings
	static var labelColor: UIColor { return Colors.getColor(.MyBlue) }
	static var labelRadius: CGFloat { return 7 }
	
	// Mark:-
	// Mark: Segmented controls
	static var segControlsBackColor: UIColor { return Colors.getColor(.Clear) }
	static var segControlsTintColor: UIColor { return Colors.getColor(.MyBlue) }
	static var segControlsRadius: CGFloat { return 1 }
	
	// MARK:-
	// MARK: Buttons settings
	static var buttonsColor: UIColor { return Colors.getColor(.MyBlue) }
	static var buttonsRadius: CGFloat { return 15 }
	static var buttonsTextColor: UIColor { return Colors.getColor(.White) }
	
	// MARK:-
	// MARK: Cell colors
	static var cellBackgroundColor: UIColor { return Colors.getColor(.MyBlue) }
	static var cellHighlightedColor: UIColor { return Colors.getColor(.MyBlue_2) }
	static var cellTextcolor: UIColor { return Colors.getColor(.White) }
	
	// MARK:-
	// MARK: Popover color
	static var popoverBackgroundColor: UIColor { return Colors.getColor(.White) }
	static var playButtonPlayColor: UIColor { return popoverBackgroundColor }
	static var recordButtonRecordColor: UIColor { return popoverBackgroundColor }
	
	// MARK:-
	// MARK: Questionnaire slider color
	static var appSliderColor: UIColor { return Colors.getColor(.MyBlue) }
}