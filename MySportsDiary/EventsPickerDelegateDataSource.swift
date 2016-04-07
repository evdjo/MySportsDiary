//
//  EventsPickerDelegate.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 26/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import UIKit

class EventsPickerDelegateDataSource: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {

    private let eventNames = ["Self-belief", "Leadership", "Honesty",
        "Kindness", "Team work", "Respect", "Other"]
    let parentVC: NewEventVC?;

    init(parentVC: NewEventVC) {
        self.parentVC = parentVC;
        super.init();
    }
    ///
    /// Data Source Methods
    ///
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView,
        numberOfRowsInComponent component: Int) -> Int {
            return eventNames.count;
    }

    ///
    /// Delegate Methods
    ///
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int)
        -> String? {

            return eventNames[row];
    }

    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        parentVC?.newSkillEntered(eventNames[row]);
    }

//    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
//        if (component == 0) {
//            return pickerView.frame.width / 6;
//        } else {
//            return pickerView.frame.width * 5 / 6;
//        }
//    }
}
