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
		let app = UIApplication.sharedApplication();
		NSNotificationCenter.defaultCenter().addObserver(
			self,
			selector: #selector(self.appState),
			name: UIApplicationWillEnterForegroundNotification,
			object: app)
		appState();
	}
	
	func appState() {
		checkIfDiaryPeriodIsOver();
		
		switch DataManagerInstance().getAppState() ?? .Initial {
		case .Diary:
			self.selectedIndex = 1;
			self.tabBar.items![0].enabled = true;
			self.tabBar.items![1].enabled = true;
			self.tabBar.items![2].enabled = true;
		case .Initial, .Final, .Epilogue:
			self.selectedIndex = 0;
			self.tabBar.items![0].enabled = true;
			self.tabBar.items![1].enabled = false;
			self.tabBar.items![2].enabled = false;
		}
	}
	
	private func checkIfDiaryPeriodIsOver() {
		if let endDateString = DataManagerInstance().getDiaryEndDate() {
			if let endDate = stringDate(endDateString) {
				let nowDate = NSDate();
				switch endDate.compare(nowDate) {
				case .OrderedAscending, .OrderedSame:
					DataManagerInstance().setAppState(.Final);
				case .OrderedDescending:
					break; // no op
				}
			}
		}
	}
	///
	/// If selecting the very same tab bar, don't select.
	///
	func tabBarController(tabBarController: UITabBarController,
		shouldSelectViewController viewController: UIViewController) -> Bool {
			let targetIndex = self.viewControllers?.indexOf(viewController);
			if targetIndex == self.selectedIndex {
				return false;
			}
			return true;
	}
	///
	/// Navigate to root of navigation controller when switching tabs
	///
	func tabBarController(tabBarController: UITabBarController,
		didSelectViewController viewController: UIViewController) {
			if let vc = viewController as? UINavigationController {
				vc.popToRootViewControllerAnimated(false);
			}
	}
}

