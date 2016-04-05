//
//  MySportsDiaryTests.swift
//  MySportsDiaryTests
//
//  Created by Evdzhan Mustafa on 12/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import XCTest
@testable import MySportsDiary
class MySportsDiaryTests: XCTestCase {

    override func setUp() {

        DataManager.getManagerInstance().purgeData();

        DataManager.getManagerInstance().setAppState(.Initial);
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testAppInitialStartAppStateIsInitial() {
        let appState = DataManager.getManagerInstance().getAppState();
        XCTAssertEqual(appState, .Initial);
    }

    func testAppInitialStartAppStateIsInitialChangeToDiary() {
        var appState = DataManager.getManagerInstance().getAppState();
        XCTAssertEqual(appState, .Initial);

        DataManager.getManagerInstance().setAppState(.Diary);
        appState = DataManager.getManagerInstance().getAppState();
        XCTAssertEqual(appState, .Diary);
    }

    func testAppInitialStartAppStateIsInitialChangeToFinal() {
        var appState = DataManager.getManagerInstance().getAppState();
        XCTAssertEqual(appState, .Initial);

        DataManager.getManagerInstance().setAppState(.Final);
        appState = DataManager.getManagerInstance().getAppState();
        XCTAssertEqual(appState, .Final);
    }
}
