//
//  myCopy_test.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 12/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import XCTest
@testable import MySportsDiary

class myCopy_test: DataUtilTest {

	func test_myCopy_FileUnderCachesToCaches() {
		let file = fileURL(file: myFile, under: .CachesDirectory)
		let destination = fileURL(file: myFile + "copy", under: .CachesDirectory);
		XCTAssertFalse(NSFileManager.defaultManager().fileExistsAtPath(file.path!));
		XCTAssertFalse(NSFileManager.defaultManager().fileExistsAtPath(destination.path!));

		NSFileManager.defaultManager().createFileAtPath(file.path!, contents: nil, attributes: nil);
		XCTAssertTrue(NSFileManager.defaultManager().fileExistsAtPath(file.path!));

		myCopy(file, toPath: destination);

		XCTAssertTrue(NSFileManager.defaultManager().fileExistsAtPath(file.path!));
		XCTAssertTrue(NSFileManager.defaultManager().fileExistsAtPath(destination.path!));
	}

	func test_myCopy_FileUnderCachesToLibrary() {
		let file = fileURL(file: myFile, under: .CachesDirectory)
		let destination = fileURL(file: myFile, under: .LibraryDirectory);
		XCTAssertFalse(NSFileManager.defaultManager().fileExistsAtPath(file.path!));
		XCTAssertFalse(NSFileManager.defaultManager().fileExistsAtPath(destination.path!));

		NSFileManager.defaultManager().createFileAtPath(file.path!, contents: nil, attributes: nil);
		XCTAssertTrue(NSFileManager.defaultManager().fileExistsAtPath(file.path!));

		myCopy(file, toPath: destination);

		XCTAssertTrue(NSFileManager.defaultManager().fileExistsAtPath(file.path!));
		XCTAssertTrue(NSFileManager.defaultManager().fileExistsAtPath(destination.path!));
	}

	func test_myCopy_FileUnderLibraryToCaches() {
		let file = fileURL(file: myFile, under: .LibraryDirectory)
		let destination = fileURL(file: myFile, under: .CachesDirectory);
		XCTAssertFalse(NSFileManager.defaultManager().fileExistsAtPath(file.path!));
		XCTAssertFalse(NSFileManager.defaultManager().fileExistsAtPath(destination.path!));

		NSFileManager.defaultManager().createFileAtPath(file.path!, contents: nil, attributes: nil);
		XCTAssertTrue(NSFileManager.defaultManager().fileExistsAtPath(file.path!));

		myCopy(file, toPath: destination);

		XCTAssertTrue(NSFileManager.defaultManager().fileExistsAtPath(file.path!));
		XCTAssertTrue(NSFileManager.defaultManager().fileExistsAtPath(destination.path!));
	}

	func test_myCopy_FileUnderLibraryToLibrary() {
		let file = fileURL(file: myFile, under: .LibraryDirectory)
		let destination = fileURL(file: myFile + "copy", under: .LibraryDirectory);
		XCTAssertFalse(NSFileManager.defaultManager().fileExistsAtPath(file.path!));
		XCTAssertFalse(NSFileManager.defaultManager().fileExistsAtPath(destination.path!));

		NSFileManager.defaultManager().createFileAtPath(file.path!, contents: nil, attributes: nil);
		XCTAssertTrue(NSFileManager.defaultManager().fileExistsAtPath(file.path!));

		myCopy(file, toPath: destination);

		XCTAssertTrue(NSFileManager.defaultManager().fileExistsAtPath(file.path!));
		XCTAssertTrue(NSFileManager.defaultManager().fileExistsAtPath(destination.path!));
	}
}
