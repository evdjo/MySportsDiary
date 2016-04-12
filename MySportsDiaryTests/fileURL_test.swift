//
//  fileURL_test.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 12/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import XCTest
@testable import MySportsDiary

class fileURL_test: DataUtilTest {

	func test_fileURL_Library() {
		let url = fileURL(file: myFile, under: .LibraryDirectory).absoluteString;
		let expectedSuffix = "Library/" + myFile
		XCTAssertTrue(url.hasSuffix(expectedSuffix));
	}

	func test_fileURL_Caches() {
		let url = fileURL(file: myFile, under: .CachesDirectory).absoluteString;
		let expectedSuffix = "Caches/" + myFile
		XCTAssertTrue(url.hasSuffix(expectedSuffix));
	}

	func test_fileURLUnderParent_Caches() {
		let dir_url = fileURL(file: myDir, under: .CachesDirectory);
		let url = fileURLUnderParent(file: myFile, parent: dir_url).absoluteString;
		let expectedSuffix = "Caches/" + myDir + "/" + myFile
		XCTAssertTrue(url.hasSuffix(expectedSuffix));
	}

	func test_fileURLUnderParent_Library() {
		let dir_url = fileURL(file: myDir, under: .LibraryDirectory);
		let url = fileURLUnderParent(file: myFile, parent: dir_url).absoluteString;
		let expectedSuffix = "Library/" + myDir + "/" + myFile
		XCTAssertTrue(url.hasSuffix(expectedSuffix));
	}

	func test_fileURL_assertFileIsNotCreated() {
		let file = fileURL(file: "myFileCopy13.txt", under: .CachesDirectory);
		XCTAssertFalse(NSFileManager.defaultManager().fileExistsAtPath(file.path!));
	}
}
