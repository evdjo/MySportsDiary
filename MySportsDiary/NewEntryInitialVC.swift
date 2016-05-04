//
//  NewEntryInitialVC.swift
//  MyRugbyDiary
//
//  Created by Evdzhan Mustafa on 08/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import UIKit

class NewEntryInitialVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

/// The picker with the skill list to choose from
	@IBOutlet weak var skillPickerView: UIPickerView!

	@IBOutlet weak var nextButton: UIButton!
///
/// Set the delegates, and select the middle element in the picker
///
    override func viewDidLoad() {
		super.viewDidLoad();
		skillPickerView.dataSource = self;
		skillPickerView.delegate = self;
		skillPickerView.selectRow(SKILLS.count / 2,
			inComponent: 0, animated: false);
		setButton(nextButton);
	}

///
/// Hide the navigation bar
///
    override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated);
		navigationController?.navigationBarHidden = true;
	}
    
///
/// Set the SingleEntryViewVC's type to .New,
/// Also set it's skill to the selected one.
///
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		let vc = segue.destinationViewController as! SingleEntryViewerVC;
		vc.entryType = .New;
		vc.skill = SKILLS[skillPickerView.selectedRowInComponent(0)]
	}
	
///
/// skillPickerView delegate methods
///
	func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return SKILLS[row];
	}
    
///
/// skillPickerView data source methods
///
	func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
		return 1
	}
	func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return SKILLS.count;
	}
}
