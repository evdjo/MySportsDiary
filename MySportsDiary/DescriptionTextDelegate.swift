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

        return textView.text.characters.count + (text.characters.count - range.length) <= 20
    }

    func textViewShouldBeginEditing(textView: UITextView) -> Bool {

        if textView.text == enterText {
            textView.text = "";
            textView.textColor = UIColor.blackColor();
        }
        return true;
    }
    func textViewDidEndEditing(textView: UITextView) {
        if textView.text.characters.count == 0 {
            textView.text = enterText;
            textView.textColor = UIColor.lightGrayColor();
        }
    }
}
