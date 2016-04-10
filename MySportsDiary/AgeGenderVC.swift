//
//  AgeAndGenderViewController.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 11/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import UIKit

class AgeGenderVC: UIViewController {

	@IBOutlet weak var genderSegmentedControl: UISegmentedControl!
	@IBOutlet weak var ageSlider: UISlider!
	@IBOutlet weak var ageLabel: UILabel!
	@IBOutlet weak var nextButton: UIButton!

	private var ageIsSet = false;
	private var genderIsSet = false;

	override func viewDidLoad() {
		/// set the accesibility identifiers -- used in testing
		genderSegmentedControl.accessibilityIdentifier = Accessibility.GenderSegmentedControl
		ageSlider.accessibilityIdentifier = Accessibility.AgeSlider;
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
		let gender = DataManager.getManagerInstance().getGender();
		if let gender = gender {
			let selectedIndex: Int = gender == .BOY ? 0 : 1;
			genderSegmentedControl.selectedSegmentIndex = selectedIndex;
			genderIsSet = true ;
		} else { print("gender was not set yet, not loading "); genderIsSet = false; }
	}
	private func loadAge() {
		let age = DataManager.getManagerInstance().getAge();
		if let age = age {
			ageLabel.text = String(age);
			ageSlider.value = Float(age);
			ageIsSet = true;
		} else { print("age was not set yet, not loading ");ageIsSet = false; }
	}

	///
	/// Age slider
	///
	@IBAction func onAgeSliderMoved(sender: UISlider) {
		ageLabel.text = String(Int(ageSlider.value));
		// ageIsSet = true;
	}
	@IBAction func onAgeSliderValueChanged(sender: UISlider) {
		DataManager.getManagerInstance().setAge(Int(ageSlider.value));
		ageIsSet = true;
		if (genderIsSet) {
			nextButton.enabled = true;
			nextButton.alpha = 1.0;
		}
	}
	///
	/// Gender segment control
	///
	@IBAction func onGenderSegmentChanged(sender: AnyObject) {
		let gender: Gender = genderSegmentedControl.selectedSegmentIndex == 0 ? .BOY : .GIRL;
		DataManager.getManagerInstance().setGender(gender);
		genderIsSet = true;
		if (ageIsSet) {
			nextButton.enabled = true;
			nextButton.alpha = 1.0;
		}
	}
}
