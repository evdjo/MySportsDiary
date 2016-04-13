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

	func tabBarController(tabBarController: UITabBarController,
		didSelectViewController viewController: UIViewController) {
			if let vc = viewController as? UINavigationController {
				vc.popViewControllerAnimated(false);
			}
	}
}

// // SOURCE FROM -> https://www.reddit.com/r/swift/comments/2fc1ze/animated_switch_when_using_tabbarcontroller/
