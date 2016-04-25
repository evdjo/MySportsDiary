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
	
	func application(application: UIApplication, didFinishLaunchingWithOptions
		launchOptions: [NSObject: AnyObject]?) -> Bool {
			clearContentsIfTestEnvironment();
			initApp();
			return true;
	}
	
	func applicationWillTerminate(application: UIApplication) {
		clearContentsIfTestEnvironment();
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
			case "delete_tempmedia":
				DataManagerInstance().purgeTempMedia()
			case "delete_entries_db":
				DataManagerInstance().purgeEntries();
			case "insert_dummy_entries":
				DataManagerInstance().purgeEntries();
				DataManagerInstance().generateDummyEntries();
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
}
