//
//  QuestionnaireViewController.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 11/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import UIKit

class InitialVC: UIViewController {
	@IBOutlet weak var newEntryButton: UIButton!
	@IBAction func onNewEntryPressed(sender: AnyObject) {
		self.tabBarController?.selectedIndex = 1;
	}

	@IBOutlet weak var mainLabel: UILabel!;
	@IBOutlet weak var beginButton: UIButton!;

	///
	/// Hide back button. If enable the second and third
	/// tab bars if we are in Diary mode, else only the first tab bar is enabled.
	///
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated);
		// hide the bar above, since there is no back screen to move to,
		self.navigationController?.setNavigationBarHidden(true, animated: false);

		let appState = DataManagerInstance().getAppState() ?? .Initial
		switch (appState) {
		case (.Diary):
			mainLabel.text = DIARY_TEXT + dateToDisplay;
			newEntryButton.hidden = false;
			newEntryButton.enabled = true;
			beginButton.hidden = true;

		case (.Initial), (.Final):
			newEntryButton.hidden = true;
			newEntryButton.enabled = false;
			beginButton.hidden = false;
			mainLabel.text = appState == .Initial ? WELCOME_TEXT : FINAL_TEXT;
		}
	}

	///
	/// See if it is the first survey or final survey...
	///
	@IBAction func onSurveyBegin(sender: AnyObject) {
		let appState = DataManagerInstance().getAppState() ?? .Initial;
		if (appState == .Initial) {
			self.performSegueWithIdentifier("AgeAndGenderSegue", sender: sender);
		} else {
			self.performSegueWithIdentifier("QuestionnaireSegue", sender: sender);
		}
	}

	private var dateToDisplay: String {
		get {
			if let dateString = DataManagerInstance().getDiaryEndDate() {
				if let date = stringDate(dateString) {
					return "\n\n\(DIARY_DATE_TEXT)\n\(screenDateString(date))"
				}
			}
			return "";
		}
	}
}
