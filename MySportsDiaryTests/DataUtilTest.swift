//
//  DataUtilTest.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 12/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import XCTest
@testable import MySportsDiary
class DataUtilTest: XCTestCase {
	let manager = NSFileManager.defaultManager();
	let myFile = "myFile";
	let myDir = "myDir";
	let mySubDir = "mySubDir";
	override func setUp() {
		super.setUp();
		deleteEveryThingUnder(.LibraryDirectory);
	}
	override func tearDown() {
		super.tearDown()
		deleteEveryThingUnder(.LibraryDirectory);
	}

	func testDataManagerPropery() {
		let manager = MySportsDiary.fileManager;
		XCTAssertEqual(manager, NSFileManager.defaultManager(),
			"The manager used is not valid!.")
	}

	func test_fileIsDir_True() {
		let file = dirURL(.CachesDirectory);
		XCTAssertTrue(fileIsDir(file));
	}
	func test_fileIsDir_False() {
		let file = fileURL(file: "myFile14.txt", under: .CachesDirectory)
		NSFileManager.defaultManager().createFileAtPath(file.path!, contents: nil, attributes: nil);
		XCTAssertFalse(fileIsDir(file));
	}
}
