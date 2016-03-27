//
//  EventsPickerDelegate.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 26/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import UIKit

class EventsPickerDelegateDataSource: NSObject, UIPickerViewDelegate,  UIPickerViewDataSource {
    
    
    private let eventNames = [
        "Leadership", "Fear", "Loneliness", "Anxiety", "Upset",
        "Excited", "Angry", "Happy", "Stressed", "Vulnarable","Guilty","Depressed"]
    
    
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
    func pickerView(pickerView: UIPickerView,titleForRow row: Int, forComponent component: Int)
        -> String? {
            return eventNames[row];
    }
}
