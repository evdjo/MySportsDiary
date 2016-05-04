//
//  MasterTabBarViewController.swift
//  MyRugbyDiary
//
//  Created by Evdzhan Mustafa on 11/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import UIKit

///
/// This is the main tab bar view controller.
/// It leads to:
///     - index 0 --> InitialVC
///     - index 1 --> NewEntryInitialVC
///     - index 2 --> AllEntriesViewerVC
///
class MasterTabBarViewController: UITabBarController,
UITabBarControllerDelegate {
	///
/// Set self as the delegate.
///
/// Add self as observer to WillEnterForegroundNotification
///
/// Check if the diarty period is over.
///
/// Set the tab bar's enabledness based on what state we we're in.
///
	override func viewDidLoad() {
		super.viewDidLoad()
		self.delegate = self;
		let app = UIApplication.sharedApplication();
		NSNotificationCenter.defaultCenter().addObserver(
			self,
			selector: #selector(self.refreshBasedOnAppState),
			name: UIApplicationWillEnterForegroundNotification,
			object: app)
		refreshBasedOnAppState();
	}
///
/// Check if diary period is over. Set which tabs are enabled.
///
	func refreshBasedOnAppState() {
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
/// (If selecting the very same first ab bar, don't select navigate back)
/// The above is false. Now default to true. Keeping old code in case
/// requirements change again.
///
	func tabBarController(
		tabBarController: UITabBarController,
		shouldSelectViewController viewController: UIViewController)
		-> Bool
	{
		if 0 == selectedIndex {
			let newSelectedIndex = viewControllers?.indexOf(viewController);
			let newSelectedIsCurrentSelected = newSelectedIndex == selectedIndex;
			let shouldSelect = !newSelectedIsCurrentSelected; // reverse it
			return shouldSelect;
		}
		
		return true; // read comments above. Don't delete please.
	}
///
/// Navigate to root of navigation controller when switching tabs
///
//	func tabBarController(
//		tabBarController: UITabBarController,
//		didSelectViewController viewController: UIViewController)
//		-> Void
//	{
//		if 1 == selectedIndex || 2 == selectedIndex {
//			if let vc = viewController as? UINavigationController {
//				vc.popToRootViewControllerAnimated(false);
//			}
//		}
//	}
}

