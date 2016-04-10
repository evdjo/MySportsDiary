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

        DataManagerInstance().purgeData();

        DataManagerInstance().setAppState(.Initial);
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testAppInitialStartAppStateIsInitial() {
        let appState = DataManagerInstance().getAppState();
        XCTAssertEqual(appState, .Initial);
    }

    func testAppInitialStartAppStateIsInitialChangeToDiary() {
        var appState = DataManagerInstance().getAppState();
        XCTAssertEqual(appState, .Initial);

        DataManagerInstance().setAppState(.Diary);
        appState = DataManagerInstance().getAppState();
        XCTAssertEqual(appState, .Diary);
    }

    func testAppInitialStartAppStateIsInitialChangeToFinal() {
        var appState = DataManagerInstance().getAppState();
        XCTAssertEqual(appState, .Initial);

        DataManagerInstance().setAppState(.Final);
        appState = DataManagerInstance().getAppState();
        XCTAssertEqual(appState, .Final);
    }
}
