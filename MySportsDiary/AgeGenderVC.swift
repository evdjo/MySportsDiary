//
//  AgeAndGenderViewController.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 11/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import UIKit

class AgeGenderVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
	@IBOutlet weak var genderSegmentedControl: UISegmentedControl!
	@IBOutlet weak var nextButton: UIButton!
	@IBOutlet weak var agePickerView: UIPickerView!
	
	private var ageIsSet = false;
	private var genderIsSet = false;
	
	override func viewDidLoad() {
		agePickerView.delegate = self;
		agePickerView.dataSource = self;
		setButton(nextButton);
		setSegmentedControl(genderSegmentedControl);
	}
	
	///
	/// Put age and gender back
	/// enable/disable next button
	///
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated);
		loadAge();
		loadGender();
		if (ageIsSet && genderIsSet) {
			nextButton.enabled = true;
			nextButton.alpha = 1.0;
		} else {
			nextButton.enabled = false;
			nextButton.alpha = 0.5;
		}
		
		self.navigationController?.setNavigationBarHidden(false, animated: animated);
	}
	///
	/// Persist the age and gender
	///
	private func loadGender() {
		let gender = DataManagerInstance().getGender();
		if let gender = gender {
			let selectedIndex: Int = gender == .BOY ? 0 : 1;
			genderSegmentedControl.selectedSegmentIndex = selectedIndex;
			genderIsSet = true ;
		} else {
			genderIsSet = false;
		}
	}
	private func loadAge() {
		let age = DataManagerInstance().getAge();
		if let age = age {
			agePickerView.selectRow(age, inComponent: 0, animated: false);
			ageIsSet = true;
		} else {
			ageIsSet = false;
		}
	}
	
	///
	/// Age picker
	//
	func pickerView(pickerView: UIPickerView, didSelectRow row: Int,
		inComponent component: Int) {
			if (row == 0) {
				ageIsSet = false;
				nextButton.enabled = false;
				nextButton.alpha = 0.5;
			} else {
				DataManagerInstance().setAge(row);
				ageIsSet = true;
				if (genderIsSet) {
					nextButton.enabled = true;
					nextButton.alpha = 1.0;
				}
			}
	}
	
	func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
		return 1;
	}
	
	func pickerView(pickerView: UIPickerView,
		numberOfRowsInComponent component: Int) -> Int {
			return 150;
	}
	
	func pickerView(pickerView: UIPickerView, titleForRow row: Int,
		forComponent component: Int) -> String? {
			if (row == 0) {
				return " ";
			}
			return String(row);
	}
	///
	/// Gender segment control
	///
	@IBAction func onGenderSegmentChanged(sender: AnyObject) {
		let gender: Gender =
			genderSegmentedControl.selectedSegmentIndex == 0 ? .BOY : .GIRL;
		
		DataManagerInstance().setGender(gender);
		genderIsSet = true;
		if (ageIsSet) {
			nextButton.enabled = true;
			nextButton.alpha = 1.0;
		}
	}
}
