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
				DataManagerInstance().purgeAllData()
			case "delete_app":
				DataManagerInstance().purgeAppData()
			case "delete_userdata":
				DataManagerInstance().purgeUserData()
			case "delete_questionnaireanswers":
				DataManagerInstance().purgeQuestionnaireAnswers()
			//case "delete_tempmedia":
			//	DataManagerInstance().purgeTempMedia(TEMP_DIR_URL)
			case "delete_entries_db":
				DataManagerInstance().purgeDB()
			default:
				print("Warning -- unnrecognized launch argument: \(arg)")
			}
		}
	}

	private func initApp() {
		if DataManagerInstance().getAppState() == nil {
			DataManagerInstance().setAppState(.Initial);
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
