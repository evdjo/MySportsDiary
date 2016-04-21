//
//  InitialViewUITest.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 21/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import XCTest

class InitialViewUITest: XCTestCase {
	override func setUp() {
		super.setUp()
		continueAfterFailure = false
		XCUIApplication().launch()
	}

	override func tearDown() {
		super.tearDown()
	}

	func T1_FR1() {
		XCTAssert(XCUIApplication().staticTexts["MainLabel"].exists);
	}
	func T2_FR1() {
		XCTAssert(XCUIApplication().buttons["BeginButton"].exists);
	}
	func T3_FR1() {
		let app = XCUIApplication()
		app.buttons["BeginButton"].tap()
        XCTAssert(app.navigationBars["MySportsDiary.AgeGenderVC"].exists);
	}
}
