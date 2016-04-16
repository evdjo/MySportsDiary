//
//  NewEntryInitialVC.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 08/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import UIKit

class NewEntryInitialVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

	@IBOutlet weak var skillPickerView: UIPickerView!
	private lazy var skills = ["Self-belief", "Leadership", "Honesty",
		"Fairness", "Trustworthiness",
		"Problem solving", "Kindness",
		"Team work", "Respect", "Other"]

	override func viewDidLoad() {
		super.viewDidLoad()
		skillPickerView.dataSource = self;
		skillPickerView.delegate = self;
		skillPickerView.selectRow(skills.count / 2, inComponent: 0, animated: false);
	}

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated);
		navigationController?.navigationBarHidden = true;
	}

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		let vc = segue.destinationViewController as! SingleEntryViewerVC;
		vc.entryType = .New;
		vc.skill = skills[skillPickerView.selectedRowInComponent(0)]
	}

	///
	/// skillPickerView delegate methods
	//
	func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return skills[row];
	}
	///
	/// skillPickerView data source methods
	//
	func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
		return 1
	}
	func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return skills.count;
	}
}
