//
//  AppDelegate.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 11/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		clearContentsIfTestEnvironment();
		initApp();
		return true;
	}

	private func clearContentsIfTestEnvironment() {
		for arg in Process.arguments {
			print(arg);
			switch (arg) {
			case "delete_all":
				DataManager.getManagerInstance().purgeAllData();
			case "delete_app":
				DataManager.getManagerInstance().purgeAppData();
			case "delete_userdata":
				DataManager.getManagerInstance().purgeUserData()
			case "delete_questionnaireanswers":
				DataManager.getManagerInstance().purgeQuestionnaireAnswers();
			case "delete_tempmedia":
				DataManager.getManagerInstance().purgeTempMedia()
			default:
				print("Warning -- unnrecognized launch argument: \(arg)");
			}
		}
	}

	private func initApp() {
		if DataManager.getManagerInstance().getAppState() == nil {
			DataManager.getManagerInstance().setAppState(.Initial);
		}
	}
	func applicationWillTerminate(application: UIApplication) {
		clearContentsIfTestEnvironment();
	}

//	func applicationWillResignActive(application: UIApplication) {
//	}
//
//	func applicationDidEnterBackground(application: UIApplication) {
//	}
//
//	func applicationWillEnterForeground(application: UIApplication) {
//	}
//
//	func applicationDidBecomeActive(application: UIApplication) {
//	}
}
