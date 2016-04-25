//
//  QuestionnaireViewController.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 11/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import UIKit
import QuartzCore
class InitialVC: UIViewController {
	@IBOutlet weak var mainLabel: UILabel!;
	@IBOutlet weak var beginButton: UIButton!;
	@IBOutlet weak var newEntryButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad();
		setButton(beginButton);
		setButton(newEntryButton);
	}
	///
	/// Hide back button. If enable the second and third
	/// tab bars if we are in Diary mode, else only the first tab bar is enabled.
	///
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated);
		// hide the bar above, since there is no back screen to move to,
		self.navigationController?.setNavigationBarHidden(true, animated: false);
		setUpBasedOnAppState();
	}
	
	private func setUpBasedOnAppState() {
		let appState = DataManagerInstance().getAppState() ?? .Initial
		switch (appState) {
		case (.Initial):
			newEntryButton.hidden = true;
			beginButton.hidden = false;
			mainLabel.text = WELCOME_TEXT;
		case (.Diary):
			newEntryButton.hidden = false;
			beginButton.hidden = true;
			mainLabel.text = DIARY_TEXT + dateToDisplay;
		case (.Final):
			newEntryButton.hidden = true;
			beginButton.hidden = false;
			mainLabel.text = FINAL_TEXT
		case (.Epilogue):
			newEntryButton.hidden = true;
			beginButton.hidden = true;
			mainLabel.text = EPILOGUE_TEXT;
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
	
	@IBAction func onNewEntryPressed(sender: AnyObject) {
		self.tabBarController?.selectedIndex = 1;
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
	@IBAction func on_developer_tap(sender: AnyObject) {
		DataManagerInstance().purgeAllData();
		DataManagerInstance().setAppState(.Initial);
		(tabBarController as? MasterTabBarViewController)?.refreshBasedOnAppState();
		setUpBasedOnAppState();
	}
}
