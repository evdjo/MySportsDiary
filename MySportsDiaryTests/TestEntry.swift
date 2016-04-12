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
	/// <-------------- PHOTO (IN)DIFFERENCE -------------->
	///
	func testEntriesAreEqualBothPhotosNonNil() {
		let entryA = Entry(entry_id: 0, skill: "a", description: "b", date_time: "c", latitude: 1.0,
			longitude: 1.0, photos: ["a", "b", "c"], audio: nil, video: nil);
		let entryB = Entry(entry_id: 0, skill: "a", description: "b", date_time: "c", latitude: 1.0,
			longitude: 1.0, photos: ["a", "b", "c"], audio: nil, video: nil);
		XCTAssert(entryA == entryB)
	}
	func testEntriesAreNOTEqualOnePhotosIsNil() {
		let entryA = Entry(entry_id: 0, skill: "a", description: "b", date_time: "c", latitude: 1.0,
			longitude: 1.0, photos: ["a", "b", "c"], audio: nil, video: nil);
		let entryB = Entry(entry_id: 0, skill: "a", description: "b", date_time: "c", latitude: 1.0,
			longitude: 1.0, photos: nil, audio: nil, video: nil);
		XCTAssert(entryA != entryB)
	}
	func testEntriesAreEqualBothPhotosNil() {
		let entryA = Entry(entry_id: 0, skill: "a", description: "b", date_time: "c", latitude: 1.0,
			longitude: 1.0, photos: nil, audio: nil, video: nil);
		let entryB = Entry(entry_id: 0, skill: "a", description: "b", date_time: "c", latitude: 1.0,
			longitude: 1.0, photos: nil, audio: nil, video: nil);
		XCTAssert(entryA == entryB)
	}
	///
	/// <-------------- SKILL DIFFERENCE -------------->
	///
	func testEntriesAreNOTEqualSkillDifference() {
		let entryA = Entry(entry_id: 0, skill: "a", description: "b", date_time: "c", latitude: 1.0,
			longitude: 1.0, photos: ["a", "b", "c"], audio: nil, video: nil);
		let entryB = Entry(entry_id: 0, skill: "aa", description: "b", date_time: "c", latitude: 1.0,
			longitude: 1.0, photos: ["a", "b", "c"], audio: nil, video: nil);
		XCTAssert(entryA != entryB)
	}

	///
	/// <-------------- DESCRIPTION DIFFERENCE -------------->
	///
	func testEntriesAreNOTEqualDescrDifference() {
		let entryA = Entry(entry_id: 0, skill: "a", description: "b", date_time: "c", latitude: 1.0,
			longitude: 1.0, photos: ["a", "b", "c"], audio: nil, video: nil);
		let entryB = Entry(entry_id: 0, skill: "a", description: "bb", date_time: "c", latitude: 1.0,
			longitude: 1.0, photos: ["a", "b", "c"], audio: nil, video: nil);
		XCTAssert(entryA != entryB)
	}

	///
	/// <-------------- DATE TIME DIFFERENCE -------------->
	///
	func testEntriesAreNOTEqualDateTimeDifference() {
		let entryA = Entry(entry_id: 0, skill: "a", description: "b", date_time: "c", latitude: 1.0,
			longitude: 1.0, photos: ["a", "b", "c"], audio: nil, video: nil);
		let entryB = Entry(entry_id: 0, skill: "a", description: "b", date_time: "cc", latitude: 1.0,
			longitude: 1.0, photos: ["a", "b", "c"], audio: nil, video: nil);
		XCTAssert(entryA != entryB)
	}

	///
	/// <-------------- LATITUDE/LONGITUDE DIFFERENCE -------------->
	///
	func testEntriesAreNOTEqualLatDifference() {
		let entryA = Entry(entry_id: 0, skill: "a", description: "b", date_time: "c", latitude: 1.0,
			longitude: 1.0, photos: ["a", "b", "c"], audio: nil, video: nil);
		let entryB = Entry(entry_id: 0, skill: "a", description: "b", date_time: "c", latitude: 2.0,
			longitude: 1.0, photos: ["a", "b", "c"], audio: nil, video: nil);
		XCTAssert(entryA != entryB)
	}
	func testEntriesAreNOTEqualLonDifference() {
		let entryA = Entry(entry_id: 0, skill: "a", description: "b", date_time: "c", latitude: 1.0,
			longitude: 1.0, photos: ["a", "b", "c"], audio: nil, video: nil);
		let entryB = Entry(entry_id: 0, skill: "a", description: "b", date_time: "c", latitude: 1.0,
			longitude: 2.0, photos: ["a", "b", "c"], audio: nil, video: nil);
		XCTAssert(entryA != entryB)
	}

	///
	/// <-------------- AUDIO (IN)DIFFERENCE -------------->
	///
	func testEntriesAreNOTEqualAudioDifferenceOneIsNil() {
		let entryA = Entry(entry_id: 0, skill: "a", description: "b", date_time: "c", latitude: 1.0,
			longitude: 1.0, photos: ["a", "b", "c"], audio: "audio.caf", video: nil);
		let entryB = Entry(entry_id: 0, skill: "a", description: "b", date_time: "c", latitude: 1.0,
			longitude: 1.0, photos: ["a", "b", "c"], audio: nil, video: nil);
		XCTAssert(entryA != entryB)
	}
	func testEntriesAreEqualAudioBothNil() {
		let entryA = Entry(entry_id: 0, skill: "a", description: "b", date_time: "c", latitude: 1.0,
			longitude: 1.0, photos: ["a", "b", "c"], audio: nil, video: nil);
		let entryB = Entry(entry_id: 0, skill: "a", description: "b", date_time: "c", latitude: 1.0,
			longitude: 1.0, photos: ["a", "b", "c"], audio: nil, video: nil);
		XCTAssert(entryA == entryB)
	}
	func testEntriesAreEqualAudioBothNonNilSameValue() {
		let entryA = Entry(entry_id: 0, skill: "a", description: "b", date_time: "c", latitude: 1.0,
			longitude: 1.0, photos: ["a", "b", "c"], audio: "audio.caf", video: nil);
		let entryB = Entry(entry_id: 0, skill: "a", description: "b", date_time: "c", latitude: 1.0,
			longitude: 1.0, photos: ["a", "b", "c"], audio: "audio.caf", video: nil);
		XCTAssert(entryA == entryB)
	}
	func testEntriesAreNOTEqualAudioBothNonNilDifferentValue() {
		let entryA = Entry(entry_id: 0, skill: "a", description: "b", date_time: "c", latitude: 1.0,
			longitude: 1.0, photos: ["a", "b", "c"], audio: "audio1.caf", video: nil);
		let entryB = Entry(entry_id: 0, skill: "a", description: "b", date_time: "c", latitude: 1.0,
			longitude: 1.0, photos: ["a", "b", "c"], audio: "audio2.caf", video: nil);
		XCTAssert(entryA != entryB)
	}
}
