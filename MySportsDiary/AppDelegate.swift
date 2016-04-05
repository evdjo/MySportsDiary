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
        if (Process.arguments.contains("TEST_ENVIRONMENT")) {
            DataManager.getManagerInstance().purgeData();
            print("TEST_ENVIRONMENT -- clearing all data!");
        }

        if (Process.arguments.contains("DELETE_TEMP_MEDIA")) {
            DataManager.getManagerInstance().purgeTempMedia();
            print("DELETE_TEMP_MEDIA -- clearing temp media!");
        }
    }
    private func initApp() {
        if DataManager.getManagerInstance().getAppState() == nil {
            DataManager.getManagerInstance().setAppState(.Initial);
        }
    }

    func applicationWillResignActive(application: UIApplication) {
    }

    func applicationDidEnterBackground(application: UIApplication) {
    }

    func applicationWillEnterForeground(application: UIApplication) {
    }

    func applicationDidBecomeActive(application: UIApplication) {
    }

    func applicationWillTerminate(application: UIApplication) {
        clearContentsIfTestEnvironment();
    }
}
