//
//  DatabaseStatements.swift
//  MyRugbyDiary
//
//  Created by Evdzhan Mustafa on 11/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation

////
/// <---------- NEED THE BELOW TWO WHEN INSERTING STRINGS TO THE DB ---------->
//

/// promise the string won't change, so use our copy
let SQLITE_STATIC = unsafeBitCast(0, sqlite3_destructor_type.self)

/// force the string to be copied by sqlite
let SQLITE_TRANSIENT = unsafeBitCast(-1, sqlite3_destructor_type.self)

///
/// Open a database at the passed dbURL parameter
///
/// - parameters:
///   - dbURL: NSURL pointing to the db file to open
/// - returns: pointer handle to the db if opened successfully, else nil
internal func openDB(dbURL: NSURL) -> COpaquePointer? {
	var db: COpaquePointer = nil;
	let db_path: String! = dbURL.path;

	guard db_path != nil else {
		print("Couldn't find the requested file: ");
		debugPrint(dbURL);
		return nil;
	}
	let status = sqlite3_open(db_path, &db)
	if SQLITE_OK != status {
		print("Opening db at location \(dbURL) has failed.");
		print("sqlite3 reports : \(status)");
		sqlite3_close(db);
		return nil;
	}
	return db;
}

///
/// Create table inside the passed database, represented by db.
/// The 'create' statement is used to create the db.
///
/// - parameters:
///   - db: handle to the db, in which the new table is created
///   - create: the create statement for the new table
/// - returns: whether the table was successfully created.

internal func createTable(db: COpaquePointer, create: String) -> Bool {
	var errMsg: UnsafeMutablePointer<Int8> = nil;
	let success = SQLITE_OK == sqlite3_exec(db, create, nil, nil, &errMsg);
	if (!success) {
		sqlite3_close(db);
		print("Table creation failed. Statement: ");
		print(create);
		print(String.fromCString(errMsg));
	}
	return success;
}

///
/// Return string from C style String. Will return empty string (aka "") if nil is found
///
/// - parameters:
///   - ptr: C style string
/// - returns: Swift style string
internal func dbString(ptr: UnsafePointer<UInt8>) -> String? {
	return String.fromCString(UnsafePointer<CChar>(ptr));
}
