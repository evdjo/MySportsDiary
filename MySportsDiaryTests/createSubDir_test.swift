//
//  createSubDir_test.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 12/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import XCTest
@testable import MySportsDiary

class createSubDir_test: DataUtilTest {

	func test_createSubDir_Library() {
		let url = createSubDir(dir: myDir, under: .LibraryDirectory);
		XCTAssertTrue(NSFileManager.defaultManager().fileExistsAtPath(url.path!));
		let expectedSuffix = "Library/" + myDir
		XCTAssertTrue(url.absoluteString.hasSuffix(expectedSuffix));
	}
	func test_createSubDir_Caches() {
		let url = createSubDir(dir: myDir, under: .CachesDirectory);
		XCTAssertTrue(NSFileManager.defaultManager().fileExistsAtPath(url.path!));
		let expectedSuffix = "Caches/" + myDir
		XCTAssertTrue(url.absoluteString.hasSuffix(expectedSuffix));
	}

	func test_createSubDirUnderParent_Library() {
		let parent = createSubDir(dir: myDir, under: .LibraryDirectory);
		let url = createSubDirUnderParent(dir: mySubDir, parent: parent);
		XCTAssertTrue(NSFileManager.defaultManager().fileExistsAtPath(url.path!));
		let expectedSuffix = "Library/" + myDir + "/" + mySubDir
		XCTAssertTrue(url.absoluteString.hasSuffix(expectedSuffix));
	}
	func test_createSubDirUnderParent_Caches() {
		let parent = createSubDir(dir: myDir, under: .CachesDirectory);
		let url = createSubDirUnderParent(dir: mySubDir, parent: parent);
		XCTAssertTrue(NSFileManager.defaultManager().fileExistsAtPath(url.path!));
		let expectedSuffix = "Caches/" + myDir + "/" + mySubDir
		XCTAssertTrue(url.absoluteString.hasSuffix(expectedSuffix));
	}
}
