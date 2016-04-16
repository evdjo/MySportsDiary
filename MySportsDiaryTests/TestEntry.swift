//
//
// This test suite tests if the Entry defined struct compares correctly with itself.
//
//
//  Created by Evdzhan Mustafa on 11/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import XCTest
@testable import MySportsDiary
class TestEntry: XCTestCase {

	///
	/// <-------------- SKILL DIFFERENCE -------------->
	///
	func testEntriesAreNOTEqualSkillDifference() {
		let entryA = Entry(entry_id: 0, skill: "a", description: "b", date_time: "c", latitude: 1.0,
			longitude: 1.0);
		let entryB = Entry(entry_id: 0, skill: "aa", description: "b", date_time: "c", latitude: 1.0,
			longitude: 1.0);
		XCTAssert(entryA != entryB)
	}

	///
	/// <-------------- DESCRIPTION DIFFERENCE -------------->
	///
	func testEntriesAreNOTEqualDescrDifference() {
		let entryA = Entry(entry_id: 0, skill: "a", description: "b", date_time: "c", latitude: 1.0,
			longitude: 1.0);
		let entryB = Entry(entry_id: 0, skill: "a", description: "bb", date_time: "c", latitude: 1.0,
			longitude: 1.0);
		XCTAssert(entryA != entryB)
	}

	///
	/// <-------------- DATE TIME DIFFERENCE -------------->
	///
	func testEntriesAreNOTEqualDateTimeDifference() {
		let entryA = Entry(entry_id: 0, skill: "a", description: "b", date_time: "c", latitude: 1.0,
			longitude: 1.0);
		let entryB = Entry(entry_id: 0, skill: "a", description: "b", date_time: "cc", latitude: 1.0,
			longitude: 1.0);
		XCTAssert(entryA != entryB)
	}

	///
	/// <-------------- LATITUDE/LONGITUDE DIFFERENCE -------------->
	///
	func testEntriesAreNOTEqualLatDifference() {
		let entryA = Entry(entry_id: 0, skill: "a", description: "b", date_time: "c", latitude: 1.0,
			longitude: 1.0);
		let entryB = Entry(entry_id: 0, skill: "a", description: "b", date_time: "c", latitude: 2.0,
			longitude: 1.0);
		XCTAssert(entryA != entryB)
	}
	func testEntriesAreNOTEqualLonDifference() {
		let entryA = Entry(entry_id: 0, skill: "a", description: "b", date_time: "c", latitude: 1.0,
			longitude: 1.0);
		let entryB = Entry(entry_id: 0, skill: "a", description: "b", date_time: "c", latitude: 1.0,
			longitude: 2.0);
		XCTAssert(entryA != entryB)
	}
}
