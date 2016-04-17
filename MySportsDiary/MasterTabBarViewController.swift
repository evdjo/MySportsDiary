//
//  MasterTabBarViewController.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 11/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import UIKit

class MasterTabBarViewController: UITabBarController,
UITabBarControllerDelegate {

	override func viewDidLoad() {
		super.viewDidLoad()
		self.delegate = self;
	}
	override func viewDidAppear(animated: Bool) {

		if let endDateString = DataManagerInstance().getDiaryStart() {
			let endDate = stringDate(endDateString);
			let nowDate = NSDate();

			switch endDate.compare(nowDate) {
			case .OrderedAscending, .OrderedSame:
				DataManagerInstance().setAppState(.Final);
				self.selectedIndex = 0;

			case .OrderedDescending:
				self.selectedIndex = 1;
			}
			return;
		}

		let appState = DataManagerInstance().getAppState() ?? .Initial
		if appState == .Diary {
			self.selectedIndex = 1;
		}
	}

	func tabBarController(tabBarController: UITabBarController,
		didSelectViewController viewController: UIViewController) {
			if let vc = viewController as? UINavigationController {
				vc.popToRootViewControllerAnimated(false);
			}
	}
}

// // SOURCE FROM -> https://www.reddit.com/r/swift/comments/2fc1ze/animated_switch_when_using_tabbarcontroller/
