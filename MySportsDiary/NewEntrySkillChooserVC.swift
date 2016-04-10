//
//  SkillPickerVC.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 08/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import UIKit

class NewEntrySkillChooserVC: UIViewController, UIPickerViewDelegate,
UIPickerViewDataSource {

	@IBOutlet weak var skillPickerView: UIPickerView!
    
	let skills =
		["Self-belief", "Leadership", "Honesty", "Fairness", "Trustworthiness",
			"Problem solving", "Kindness", "Team work", "Respect", "Other"]

	override func viewDidLoad() {
		super.viewDidLoad()
		skillPickerView.dataSource = self;
		skillPickerView.delegate = self;
		skillPickerView.selectRow(skills.count / 2, inComponent: 0,
			animated: false);
	}

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated);
		self.navigationController?.navigationBarHidden = true ;
	}

	override func viewWillDisappear(animated: Bool) {
		super.viewWillDisappear(animated);
		if (navigationController?.topViewController != self) {
			self.navigationController?.navigationBarHidden = false;
		}
	}
	override func prepareForSegue(segue: UIStoryboardSegue,
		sender: AnyObject?) {
			if let vc = segue.destinationViewController
			as? NewEntryDescriptionAndMediaVC {
				vc.skill = skills[skillPickerView.selectedRowInComponent(0)]
			}
	}

	///
	/// Delegate Methods
	///
	func pickerView(pickerView: UIPickerView, titleForRow row: Int,
		forComponent component: Int) -> String? {
			return skills[row];
	}

	///
	/// Data Source Methods
	///
	func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
		return 1
	}
	func pickerView(pickerView: UIPickerView, numberOfRowsInComponent
		component: Int) -> Int {
			return skills.count;
	}
}
