//
//  EntryTests.swift
//  MyRugbyDiary
//
//  Created by Evdzhan Mustafa on 11/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import XCTest
@testable import MyRugbyDiary

class EntryDatabaseTests: XCTestCase {
	var dm = DataManagerInstance();
	override func setUp() {
		super.setUp()
		self.continueAfterFailure = false;
		DataManagerInstance().purgeEntries();
	}

	override func tearDown() {
		super.tearDown()
		DataManagerInstance().purgeEntries();
	}

	func testTwoEntriesAddedNoMedia() {
		let expected = Entry(entry_id: 2, skill: "Honesty",
			description: "I hit my manager today. I am being honest by saying it here...? WHAT!?",
			date_time: "4:20", latitude: 4.0, longitude: 5.0);
		dm.addNewEntry(expected)
		dm.addNewEntry(expected)
		let entries = dm.getEntries();
		XCTAssert(entries != nil)
		XCTAssertEqual(entries!.count, 2);
		XCTAssertEqual(entries![0], expected);
		XCTAssertEqual(entries![1], expected);
	}

	func testTwoEntriesAddedNoMediaFunnyCharatersInStringValues() {
		let expected = Entry(entry_id: 2, skill: allASCIICharsAsString(),
			description: allASCIICharsAsString(),
			date_time: "NORMAL_STRING",
			latitude: 1.0, longitude: 1.0);
		dm.addNewEntry(expected)
		dm.addNewEntry(expected)
		let entries = dm.getEntries();
		XCTAssert(entries != nil)
		XCTAssertEqual(entries!.count, 2);
		XCTAssertEqual(entries![0], expected);
		XCTAssertEqual(entries![1], expected);
	}

	func testNoEntriesAddedReturnsNilArray() {
		let entries = dm.getEntries();
		XCTAssert(entries == nil)
	}

	func testTwoEntriesAddedWithMediaFunnyCharatersInStringValues() {
		let expected1 = Entry(entry_id: 0, skill: allASCIICharsAsString(), description: NORMAL_STRING,
			date_time: dateString(NSDate()), latitude: DOUBLES[0], longitude: DOUBLES[1]);

		let expected2 = Entry(entry_id: 0, skill: allASCIICharsAsString(), description: NORMAL_STRING,
			date_time: dateString(NSDate()), latitude: DOUBLES[2], longitude: DOUBLES[3]);

		dm.addNewEntry(expected1)
		dm.addNewEntry(expected2)
		let entries = dm.getEntries();
		XCTAssert(entries != nil)
		XCTAssertEqual(entries!.count, 2);
		XCTAssertEqual(entries![0], expected1);
		XCTAssertEqual(entries![1], expected2);
	}

	func testTwoEntriesAddedWithPhotosOnly() {
		let expected1 = Entry(entry_id: 0, skill: allASCIICharsAsString(), description: NORMAL_STRING,
			date_time: dateString(NSDate()), latitude: DOUBLES[0], longitude: DOUBLES[1]);

		let expected2 = Entry(entry_id: 0, skill: allASCIICharsAsString(), description: NORMAL_STRING,
			date_time: dateString(NSDate()), latitude: DOUBLES[2], longitude: DOUBLES[3]);

		dm.addNewEntry(expected1)
		dm.addNewEntry(expected2)
		let entries = dm.getEntries();
		XCTAssert(entries != nil)
		XCTAssertEqual(entries!.count, 2);
		XCTAssertEqual(entries![0], expected1);
		XCTAssertEqual(entries![1], expected2);
	}

	func testTwoEntriesAddedWithAudioOnly() {
		let expected1 = Entry(entry_id: 0, skill: allASCIICharsAsString(), description: NORMAL_STRING,
			date_time: dateString(NSDate()), latitude: DOUBLES[0], longitude: DOUBLES[1]);

		let expected2 = Entry(entry_id: 0, skill: allASCIICharsAsString(), description: NORMAL_STRING,
			date_time: dateString(NSDate()), latitude: DOUBLES[2], longitude: DOUBLES[3]);

		dm.addNewEntry(expected1)
		dm.addNewEntry(expected2)
		let entries = dm.getEntries();
		XCTAssert(entries != nil)
		XCTAssertEqual(entries!.count, 2);
		print(); print(); print();
		debugPrint(entries![0])
		print(); print(); print();
		debugPrint(expected1);
		print(); print(); print();
		XCTAssert(entries![0] == expected1);
		XCTAssert(entries![1] == expected2);
	}

	func testTwoEntriesAddedWithVideoOnly() {
		let expected1 = Entry(entry_id: 0, skill: allASCIICharsAsString(), description: NORMAL_STRING,
			date_time: dateString(NSDate()), latitude: DOUBLES[0], longitude: DOUBLES[1]);

		let expected2 = Entry(entry_id: 0, skill: allASCIICharsAsString(), description: NORMAL_STRING,
			date_time: dateString(NSDate()), latitude: DOUBLES[2], longitude: DOUBLES[3]);

		dm.addNewEntry(expected1)
		dm.addNewEntry(expected2)
		let entries = dm.getEntries();
		XCTAssert(entries != nil)
		XCTAssertEqual(entries!.count, 2);
		XCTAssertEqual(entries![0], expected1);
		XCTAssertEqual(entries![1], expected2);
	}

	func testTwoEntriesAddedWithPhotosAndAudio() {
		let expected1 = Entry(entry_id: 0, skill: allASCIICharsAsString(), description: NORMAL_STRING,
			date_time: dateString(NSDate()), latitude: DOUBLES[0], longitude: DOUBLES[1]);

		let expected2 = Entry(entry_id: 0, skill: allASCIICharsAsString(), description: NORMAL_STRING,
			date_time: dateString(NSDate()), latitude: DOUBLES[2], longitude: DOUBLES[3]);

		dm.addNewEntry(expected1)
		dm.addNewEntry(expected2)
		let entries = dm.getEntries();
		XCTAssert(entries != nil)
		XCTAssertEqual(entries!.count, 2);
		XCTAssertEqual(entries![0], expected1);
		XCTAssertEqual(entries![1], expected2);
	}

	func testTwoEntriesAddedWithPhotosAndVideo() {
		let expected1 = Entry(entry_id: 0, skill: allASCIICharsAsString(), description: NORMAL_STRING,
			date_time: dateString(NSDate()), latitude: DOUBLES[0], longitude: DOUBLES[1]);

		let expected2 = Entry(entry_id: 0, skill: allASCIICharsAsString(), description: NORMAL_STRING,
			date_time: dateString(NSDate()), latitude: DOUBLES[2], longitude: DOUBLES[3]);

		dm.addNewEntry(expected1)
		dm.addNewEntry(expected2)
		let entries = dm.getEntries();
		XCTAssert(entries != nil)
		XCTAssertEqual(entries!.count, 2);
		XCTAssertEqual(entries![0], expected1);
		XCTAssertEqual(entries![1], expected2);
	}

	func testTwoEntriesAddedWithVideoAndAudio() {
		let expected1 = Entry(entry_id: 0, skill: allASCIICharsAsString(), description: NORMAL_STRING,
			date_time: dateString(NSDate()), latitude: DOUBLES[0], longitude: DOUBLES[1]);

		let expected2 = Entry(entry_id: 0, skill: allASCIICharsAsString(), description: NORMAL_STRING,
			date_time: dateString(NSDate()), latitude: DOUBLES[2], longitude: DOUBLES[3]);

		dm.addNewEntry(expected1)
		dm.addNewEntry(expected2)
		let entries = dm.getEntries();
		XCTAssert(entries != nil)
		XCTAssertEqual(entries!.count, 2);
		XCTAssertEqual(entries![0], expected1);
		XCTAssertEqual(entries![1], expected2);
	}

	func testTwoEntriesAddedWithAllMediaTypes() {
		let expected1 = Entry(entry_id: 0, skill: allASCIICharsAsString(), description: NORMAL_STRING,
			date_time: dateString(NSDate()), latitude: DOUBLES[0], longitude: DOUBLES[1]);

		let expected2 = Entry(entry_id: 0, skill: allASCIICharsAsString(), description: NORMAL_STRING,
			date_time: dateString(NSDate()), latitude: DOUBLES[2], longitude: DOUBLES[3]);

		dm.addNewEntry(expected1)
		dm.addNewEntry(expected2)
		let entries = dm.getEntries();
		XCTAssert(entries != nil)
		XCTAssertEqual(entries!.count, 2);
		XCTAssertEqual(entries![0], expected1);
		XCTAssertEqual(entries![1], expected2);
	}
}
