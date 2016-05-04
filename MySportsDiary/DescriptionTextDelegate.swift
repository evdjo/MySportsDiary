//
//  DescriptionTextDelegate.swift
//  MyRugbyDiary
//
//  Created by Evdzhan Mustafa on 13/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import UIKit

class DescriptionTextDelegate: NSObject, UITextViewDelegate {
	
    ///
	/// TODO -- THIS HAS TO BE TRANSLATED TO PORTUGUESSE/SPANISH !!!
	///
	let allowedCharacters = " ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.!?";
	
	///
	/// Hide the keyboard on done pressed
	///
	func textView(
		textView: UITextView,
		shouldChangeTextInRange range: NSRange,
		replacementText text: String)
		-> Bool
	{
		if text == "\n" {
			textView.resignFirstResponder();
			return false;
		}
		
        
/// TODO NEED TO TRANSLATE THE ALLOWED CHARACTERS STRING
        
//		let set = NSCharacterSet(charactersInString: allowedCharacters).invertedSet;
// 		let filtered = text
//			.componentsSeparatedByCharactersInSet(set).joinWithSeparator("");
//        
//		if filtered != text {
//			return false;
//		}
        
		
		if textView.text.characters.count
			+ (text.characters.count - range.length) > 255 {
				return false;
		}
		
		return true;
		
	}
	
	///
	/// If the text is equal to the "enterText" we delete the contents,
	/// and change the input color to black.
	///
	func textViewShouldBeginEditing(textView: UITextView) -> Bool {
		if textView.text == ENTER_TEXT {
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
			textView.text = ENTER_TEXT;
			textView.textColor = UIColor.lightGrayColor();
		}
	}
	

}
