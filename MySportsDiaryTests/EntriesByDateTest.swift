//
//  EntriesByDateTest.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 22/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import XCTest
@testable import MySportsDiary
class EntriesByDateTest: XCTestCase {
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

	func testFromTodayOnly() {
		assertCountsOfEntriesByDate(0, 0, 0);

		dm.addNewEntry(todayEntry());
		dm.addNewEntry(todayEntry());
		dm.addNewEntry(todayEntry());

		assertCountsOfEntriesByDate(3, 0, 0);
		dm.addNewEntry(todayEntry());
		assertCountsOfEntriesByDate(4, 0, 0);
	}
	func testFromWeekOnly() {
		assertCountsOfEntriesByDate(0, 0, 0);

		dm.addNewEntry(entryFrom(days: 3));
		assertCountsOfEntriesByDate(0, 1, 0);

		dm.addNewEntry(entryFrom(days: 4));
		assertCountsOfEntriesByDate(0, 2, 0);

		dm.addNewEntry(entryFrom(days: 2));
		assertCountsOfEntriesByDate(0, 3, 0);

		dm.addNewEntry(entryFrom(days: 6));
		dm.addNewEntry(entryFrom(days: 6));
		assertCountsOfEntriesByDate(0, 5, 0);
	}

	func testFromWeekAndToday() {
		assertCountsOfEntriesByDate(0, 0, 0);
		dm.addNewEntry(todayEntry());

		dm.addNewEntry(entryFrom(days: 3));
		assertCountsOfEntriesByDate(1, 1, 0);

		dm.addNewEntry(entryFrom(days: 4));
		assertCountsOfEntriesByDate(1, 2, 0);

		dm.addNewEntry(entryFrom(days: 2));
		assertCountsOfEntriesByDate(1, 3, 0);

		dm.addNewEntry(entryFrom(days: 6));
		dm.addNewEntry(entryFrom(days: 6));
		assertCountsOfEntriesByDate(1, 5, 0);

		dm.addNewEntry(todayEntry());
		assertCountsOfEntriesByDate(2, 5, 0);

		dm.addNewEntry(entryFrom(days: 2));
		assertCountsOfEntriesByDate(2, 6, 0);

		dm.addNewEntry(todayEntry());
		dm.addNewEntry(entryFrom(days: 2));
		assertCountsOfEntriesByDate(3, 7, 0);

		dm.addNewEntry(todayEntry());
		dm.addNewEntry(entryFrom(days: 2));
		dm.addNewEntry(todayEntry());
		dm.addNewEntry(entryFrom(days: 2));
		assertCountsOfEntriesByDate(5, 9, 0);
	}

	func testFromTodayAndOlder() {
		assertCountsOfEntriesByDate(0, 0, 0);
		dm.addNewEntry(todayEntry());

		dm.addNewEntry(entryFrom(days: 8));
		assertCountsOfEntriesByDate(1, 0, 1);

		dm.addNewEntry(entryFrom(days: 14));
		assertCountsOfEntriesByDate(1, 0, 2);

		dm.addNewEntry(entryFrom(days: 9));
		assertCountsOfEntriesByDate(1, 0, 3);

		dm.addNewEntry(entryFrom(days: 10));
		dm.addNewEntry(entryFrom(days: 11));
		assertCountsOfEntriesByDate(1, 0, 5);

		dm.addNewEntry(todayEntry());
		assertCountsOfEntriesByDate(2, 0, 5);

		dm.addNewEntry(entryFrom(days: 12));
		assertCountsOfEntriesByDate(2, 0, 6);

		dm.addNewEntry(todayEntry());
		dm.addNewEntry(entryFrom(days: 13));
		assertCountsOfEntriesByDate(3, 0, 7);

		dm.addNewEntry(todayEntry());
		dm.addNewEntry(entryFrom(days: 14));
		dm.addNewEntry(todayEntry());
		dm.addNewEntry(entryFrom(days: 15));
		assertCountsOfEntriesByDate(5, 0, 9);
	}

	func testFromTodayWeekAndOlder() {
		assertCountsOfEntriesByDate(0, 0, 0);
		dm.addNewEntry(todayEntry());
		assertCountsOfEntriesByDate(1, 0, 0);
		dm.addNewEntry(entryFrom(days: 8));
		assertCountsOfEntriesByDate(1, 0, 1);
		dm.addNewEntry(entryFrom(days: 1));
		assertCountsOfEntriesByDate(1, 1, 1);

		dm.addNewEntry(entryFrom(days: 2));
		dm.addNewEntry(entryFrom(days: 3));
		assertCountsOfEntriesByDate(1, 3, 1);

		dm.addNewEntry(entryFrom(days: 9));
		dm.addNewEntry(entryFrom(days: 10));
		assertCountsOfEntriesByDate(1, 3, 3);

		dm.addNewEntry(todayEntry());
		dm.addNewEntry(todayEntry());
		assertCountsOfEntriesByDate(3, 3, 3);

		dm.addNewEntry(entryFrom(days: 4));
		dm.addNewEntry(entryFrom(days: 11));
		assertCountsOfEntriesByDate(3, 4, 4);

		dm.addNewEntry(entryFrom(days: 5));
		dm.addNewEntry(entryFrom(days: 6));
		dm.addNewEntry(entryFrom(days: 12));
		dm.addNewEntry(entryFrom(days: 13));
		assertCountsOfEntriesByDate(3, 6, 6);

		dm.addNewEntry(todayEntry());
		dm.addNewEntry(todayEntry());
		dm.addNewEntry(entryFrom(days: 14));
		dm.addNewEntry(entryFrom(days: 15));
		assertCountsOfEntriesByDate(5, 6, 8);

		dm.addNewEntry(todayEntry());
		dm.addNewEntry(todayEntry());
		dm.addNewEntry(entryFrom(days: 2));
		dm.addNewEntry(entryFrom(days: 3));
		assertCountsOfEntriesByDate(7, 8, 8);
	}

	/// Entry with todays date.
	private func todayEntry() -> Entry {
		return Entry(entry_id: -1, skill: "1", description: "1",
			date_time: dateString(NSDate()), latitude: 0, longitude: 0)
	}

	/// returns date displaced by days previously. So If today is 30/12/2000
	/// using this with days 10, will return 20/12/2000
	private func entryFrom(days days: Int) -> Entry {
		let date = NSDate();
		let daysAgo = NSCalendar.currentCalendar().dateByAddingUnit(
				.Day,
			value: -days,
			toDate: date,
			options: NSCalendarOptions(rawValue: 0))!

		return Entry(entry_id: 1, skill: "1", description: "1",
			date_time: dateString(daysAgo), latitude: 0, longitude: 0)
	}

	/// assert the count of the entries inside
	/// the entries by date returned by the data manager
	private func assertCountsOfEntriesByDate(todayCount: Int,
		_ weekCount: Int, _ olderCount: Int) {
			let entriesByDate = dm.getEntriesByDate();
			XCTAssertEqual(entriesByDate.todayEntries.count, todayCount);
			XCTAssertEqual(entriesByDate.weekEntries.count, weekCount);
			XCTAssertEqual(entriesByDate.olderEntries.count, olderCount);
	}
}
