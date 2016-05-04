//
//  myMove_test.swift
//  MyRugbyDiary
//
//  Created by Evdzhan Mustafa on 12/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import XCTest
@testable import MyRugbyDiary
class myMove_test: DataUtilTest {

	func test_myMove_FileUnderCachesToCaches() {
		let file = fileURL(file: myFile, under: .CachesDirectory)
		let destination = fileURL(file: myFile + "moved", under: .CachesDirectory);
		XCTAssertFalse(NSFileManager.defaultManager().fileExistsAtPath(file.path!));
		XCTAssertFalse(NSFileManager.defaultManager().fileExistsAtPath(destination.path!));

		NSFileManager.defaultManager().createFileAtPath(file.path!, contents: nil, attributes: nil);
		XCTAssertTrue(NSFileManager.defaultManager().fileExistsAtPath(file.path!));

		myMove(file, toPath: destination);

		XCTAssertFalse(NSFileManager.defaultManager().fileExistsAtPath(file.path!));
		XCTAssertTrue(NSFileManager.defaultManager().fileExistsAtPath(destination.path!));
	}

	func test_myMove_FileUnderCachesToLibrary() {
		let file = fileURL(file: myFile, under: .CachesDirectory)
		let destination = fileURL(file: myFile + "moved", under: .LibraryDirectory);
		XCTAssertFalse(NSFileManager.defaultManager().fileExistsAtPath(file.path!));
		XCTAssertFalse(NSFileManager.defaultManager().fileExistsAtPath(destination.path!));

		NSFileManager.defaultManager().createFileAtPath(file.path!, contents: nil, attributes: nil);
		XCTAssertTrue(NSFileManager.defaultManager().fileExistsAtPath(file.path!));

		myMove(file, toPath: destination);

		XCTAssertFalse(NSFileManager.defaultManager().fileExistsAtPath(file.path!));
		XCTAssertTrue(NSFileManager.defaultManager().fileExistsAtPath(destination.path!));
	}

	func test_myMove_FileUnderLibraryToCaches() {
		let file = fileURL(file: myFile, under: .LibraryDirectory)
		let destination = fileURL(file: myFile + "moved", under: .CachesDirectory);
		XCTAssertFalse(NSFileManager.defaultManager().fileExistsAtPath(file.path!));
		XCTAssertFalse(NSFileManager.defaultManager().fileExistsAtPath(destination.path!));

		NSFileManager.defaultManager().createFileAtPath(file.path!, contents: nil, attributes: nil);
		XCTAssertTrue(NSFileManager.defaultManager().fileExistsAtPath(file.path!));

		myMove(file, toPath: destination);

		XCTAssertFalse(NSFileManager.defaultManager().fileExistsAtPath(file.path!));
		XCTAssertTrue(NSFileManager.defaultManager().fileExistsAtPath(destination.path!));
	}

	func test_myMove_FileUnderLibraryToLibrary() {
		let file = fileURL(file: myFile, under: .LibraryDirectory)
		let destination = fileURL(file: myFile + "moved", under: .LibraryDirectory);
		XCTAssertFalse(NSFileManager.defaultManager().fileExistsAtPath(file.path!));
		XCTAssertFalse(NSFileManager.defaultManager().fileExistsAtPath(destination.path!));

		NSFileManager.defaultManager().createFileAtPath(file.path!, contents: nil, attributes: nil);
		XCTAssertTrue(NSFileManager.defaultManager().fileExistsAtPath(file.path!));

		myMove(file, toPath: destination);

		XCTAssertFalse(NSFileManager.defaultManager().fileExistsAtPath(file.path!));
		XCTAssertTrue(NSFileManager.defaultManager().fileExistsAtPath(destination.path!));
	}
}
