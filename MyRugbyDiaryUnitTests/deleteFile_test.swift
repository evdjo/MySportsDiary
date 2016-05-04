//
//  deleteFile_test.swift
//  MyRugbyDiary
//
//  Created by Evdzhan Mustafa on 12/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import XCTest
@testable import MyRugbyDiary
class deleteFile_test: DataUtilTest {

	func test_deleteFile_DirUnderCaches() {
		let dir = createSubDir(dir: myDir, under: .CachesDirectory);
		XCTAssertTrue(NSFileManager.defaultManager().fileExistsAtPath(dir.path!));
		deleteFile(file: dir);
		XCTAssertFalse(NSFileManager.defaultManager().fileExistsAtPath(dir.path!));
	}
	func test_deleteFile_DirUnderLibrary() {
		let dir = createSubDir(dir: myDir, under: .LibraryDirectory);
		XCTAssertTrue(NSFileManager.defaultManager().fileExistsAtPath(dir.path!));
		deleteFile(file: dir);
		XCTAssertFalse(NSFileManager.defaultManager().fileExistsAtPath(dir.path!));
	}

	func test_deleteFile_FileUnderCaches() {
		let file = fileURL(file: myFile, under: .CachesDirectory)
		NSFileManager.defaultManager().createFileAtPath(file.path!, contents: nil, attributes: nil);
		XCTAssertTrue(NSFileManager.defaultManager().fileExistsAtPath(file.path!));
		deleteFile(file: file);
		XCTAssertFalse(NSFileManager.defaultManager().fileExistsAtPath(file.path!));
	}
	func test_deleteFile_FileUnderLibrary() {
		let file = fileURL(file: myFile, under: .LibraryDirectory)
		NSFileManager.defaultManager().createFileAtPath(file.path!, contents: nil, attributes: nil);
		XCTAssertTrue(NSFileManager.defaultManager().fileExistsAtPath(file.path!));
		deleteFile(file: file);
		XCTAssertFalse(NSFileManager.defaultManager().fileExistsAtPath(file.path!));
	}
}
