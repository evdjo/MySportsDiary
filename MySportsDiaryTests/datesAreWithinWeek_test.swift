//
//  DateTests.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 22/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import XCTest
@testable import MySportsDiary
class datesAreWithinWeek_test: XCTestCase {
	override func setUp() {
		super.setUp()
	}

	override func tearDown() {
		super.tearDown()
	}

	func assertDifference(day0: Int, _ day1: Int, expected: Bool) {
		let comps = NSDateComponents();
		comps.setValue(day0, forComponent: .Day)
		comps.setValue(1, forComponent: .Month);
		comps.setValue(2005, forComponent: .Year);
		let testDate0 = NSCalendar.currentCalendar().dateFromComponents(comps)!;

		comps.setValue(day1, forComponent: .Day)
		let testDate1 = NSCalendar.currentCalendar().dateFromComponents(comps)!;

		let actual = datesAreWithinWeek(testDate0, testDate1);
		XCTAssertEqual(actual, expected);
	}

	func test5DaysPositiveDifference() {
		assertDifference(1, 6, expected: true);
	}

	func test5DaysNegativeDifference() {
		assertDifference(6, 1, expected: true);
	}

	func test6DaysNegativeDifference() {
		assertDifference(7, 1, expected: true);
	}

	func test6DaysPositiveDifference() {
		assertDifference(1, 7, expected: true);
	}

	func test7DaysNegativeDifference() {
		assertDifference(8, 1, expected: false);
	}

	func test7DaysPositiveDifference() {
		assertDifference(1, 8, expected: false);
	}

	func test8DaysNegativeDifference() {
		assertDifference(9, 1, expected: false);
	}

	func test8DaysPositiveDifference() {
		assertDifference(1, 9, expected: false);
	}
}
