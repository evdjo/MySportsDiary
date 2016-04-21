//
//  DescriptionTextDelegate.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 13/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import UIKit

class DescriptionTextDelegate: NSObject, UITextViewDelegate {
	///
	/// Hide the keyboard on done pressed
	///
	func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
		if text == "\n" {
			textView.resignFirstResponder();
			return false;
		}
		return textView.text.characters.count
			+ (text.characters.count - range.length) <= 255;
	}

	///
	/// If the text is equal to the "enterText" we delete the contents,
	/// and change the input color to black.
	///
	func textViewShouldBeginEditing(textView: UITextView) -> Bool {
		if textView.text == SingleEntryViewerVC.ENTER_TEXT {
			textView.text = "";
			textView.textColor = UIColor.blackColor();
		}
		return true;
	}
	///
	/// If the resulting string is empty, we put the "enterText" string back,
	/// and change the background color to lightgray.
	///
	func textViewDidEndEditing(textView: UITextView) {
		if textView.text.characters.count == 0 {
			textView.text = SingleEntryViewerVC.ENTER_TEXT;
			textView.textColor = UIColor.lightGrayColor();
		}
	}
}
