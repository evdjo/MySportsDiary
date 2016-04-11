//
//  EntryTests.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 11/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import XCTest
@testable import MySportsDiary

class EntryTests: XCTestCase {

	var dm = DataManagerInstance();
	override func setUp() {
		super.setUp()
		self.continueAfterFailure = false;
		deleteFile(file: fileURL(file: DB_NAME, under: .LibraryDirectory))
	}

	override func tearDown() {
		super.tearDown()
		deleteFile(file: fileURL(file: DB_NAME, under: .LibraryDirectory))
	}

	func testEntryAdded() {
		let expected = Entry(skill: "aaa",
			description: "bbb",
			date_time: "ccc",
			latitude: 4.0,
			longitude: 5.0,
			photos: nil,
			audio: nil,
			video: nil);
		dm.addNewEntry(expected)
		dm.addNewEntry(expected)
		let entries = dm.getEntries();
		XCTAssert(entries != nil)
		XCTAssertEqual(entries!.count, 2);
		XCTAssertEqual(entries![0], expected);
		XCTAssertEqual(entries![1], expected);
	}

	private func allASCIICharsAsString() -> String {
		var str = "";
		for i in 32 ... 126 {
			str.append(Character(UnicodeScalar(i)))
		}
		print(str);
		return str;
	}

	func testFunnyCharactersInEntryStrings() {
		let expected = Entry(skill: allASCIICharsAsString(),
			description: allASCIICharsAsString(),
			date_time: "NORMAL_STRING",
			latitude: 1.0,
			longitude: 1.0,
			photos: nil,
			audio: nil,
			video: nil);
		dm.addNewEntry(expected)
		dm.addNewEntry(expected)
		let entries = dm.getEntries();
		XCTAssert(entries != nil)
		XCTAssertEqual(entries!.count, 2);
		XCTAssertEqual(entries![0], expected);
		XCTAssertEqual(entries![1], expected);
	}
}
