//
//  SQLiteDataManagerDelegate.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 13/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation

let DB_NAME = "entries.db";

let ENTRIES_TABLE_NAME = "ENTRIES";
let ENTRIES_TABLE_CREATE = "CREATE TABLE IF NOT EXISTS \(ENTRIES_TABLE_NAME)"
	+ "(EVENT_ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "
	+ "DATE_TIME TEXT, "
	+ "SKILL TEXT, "
	+ "DESCRIPTION TEXT, "
	+ "LOCATION_LON REAL, "
	+ "LOCATION_LAT REAL"
	+ ");";
let ENTRIES_INSERT = "INSERT INTO \(ENTRIES_TABLE_NAME)"
	+ " (DATE_TIME, SKILL, DESCRIPTION, LOCATION_LON, LOCATION_LAT)"
	+ " VALUES(?, ?, ?, ?, ?);";

let PHOTOS_TABLE_NAME = "PHOTOS";
let PHOTOS_TABLE_CREATE = "CREATE TABLE IF NOT EXISTS \(PHOTOS_TABLE_NAME)("
	+ "PHOTO_ID INTEGER PRIMARY KEY, "
	+ "PATH TEXT, "
	+ "ENTRY_ID INTEGER, "
	+ "FOREIGN KEY(ENTRY_ID) REFERENCES ENTRIES(EVENT_ID)"
	+ ");";

internal func openEntriesDB() -> COpaquePointer? {
	var db: COpaquePointer = nil;
	let db_url = fileURL(file: DB_NAME, under: .LibraryDirectory);
	let db_path: String! = db_url.path;

	guard db_path != nil else {
		print("Couldn't find the requested file: ");
		debugPrint(db_url);
		return nil;
	}
	let status = sqlite3_open(db_path, &db)
	if status != SQLITE_OK {
		print("Opening db \(DB_NAME) has failed.");
		print("sqlite3 reports : \(status)");
		sqlite3_close(db);
		return nil;
	}
	return db;
}

internal func createEntriesTable(db: COpaquePointer) -> Bool {
	var errMsg: UnsafeMutablePointer<Int8> = nil;
	let result = sqlite3_exec(db, ENTRIES_TABLE_CREATE, nil, nil, &errMsg);
	if (result != SQLITE_OK) {
		print("creating user table has failed");
		sqlite3_close(db);
		return false;
	}
	return true;
}

internal func insertEntry(date_time: String, skill: String,
	description: String, latitude: Double, longitude: Double) {

		let db: COpaquePointer! = openEntriesDB();
		guard db != nil else { return; }
		guard createEntriesTable(db!) else { return; }

		var statement: COpaquePointer = nil;
		if (sqlite3_prepare_v2(db, ENTRIES_INSERT, -1, &statement, nil) == SQLITE_OK) {
			sqlite3_bind_text(statement, 1, date_time, -1, nil);
			sqlite3_bind_text(statement, 2, skill, -1, nil);
			sqlite3_bind_text(statement, 3, description, -1, nil);
			sqlite3_bind_double(statement, 4, latitude);
			sqlite3_bind_double(statement, 5, longitude);
		}

		if (sqlite3_step(statement) != SQLITE_DONE) {
			print("Error updating table"); sqlite3_close(db);
			return;
		}

		sqlite3_finalize(statement);
		sqlite3_close(db);
}

//private func saveToDB(value: Int, dbName: String, dbCreate: String, dbUpdate: String) {
//
//	var database: COpaquePointer = nil;
//	var result = sqlite3_open(fileURL(file: dbName, under: .LibraryDirectory).path!, &database);
//	if (result != SQLITE_OK) {
//		print("opening user db has failed");
//		sqlite3_close(database);
//		return; }
//
//	var errMsg: UnsafeMutablePointer<Int8> = nil;
//	result = sqlite3_exec(database, dbCreate, nil, nil, &errMsg);
//	if (result != SQLITE_OK) {
//		print("creating user table has failed");
//		sqlite3_close(database);
//		return;
//	}
//
//	var statement: COpaquePointer = nil;
//	if (sqlite3_prepare_v2(database, dbUpdate, -1, &statement, nil) == SQLITE_OK) {
//		sqlite3_bind_int(statement, 1, Int32(1));
//		sqlite3_bind_int(statement, 2, Int32(value));
//	}
//
//	if (sqlite3_step(statement) != SQLITE_DONE) {
//		print("Error updating table"); sqlite3_close(database);
//		return;
//	}
//
//	sqlite3_finalize(statement);
//	sqlite3_close(database);
//}
//
//private func loadFromDB(dbName dbName: String, dbCreate: String, dbGet: String) -> Int? {
//	// Open the db
//	var database: COpaquePointer = nil;
//	var result = sqlite3_open(dataFilePath(dbName), &database);
//	if (result != SQLITE_OK) { print("opening user DB has failed"); sqlite3_close(database); return nil; }
//	// Create the table
//	var errMsg: UnsafeMutablePointer<Int8> = nil;
//	result = sqlite3_exec(database, dbCreate, nil, nil, &errMsg);
//	if (result != SQLITE_OK) { print("creating table has failed"); sqlite3_close(database); return nil; }
//	// Fetch the value
//	var value: Int? = nil;
//	var statement: COpaquePointer = nil;
//	if (sqlite3_prepare_v2(database, dbGet, -1, &statement, nil) == SQLITE_OK) {
//		if (sqlite3_step(statement) == SQLITE_ROW) {
//			value = Int(sqlite3_column_int(statement, 1));
//		}
//		sqlite3_finalize(statement);
//	}
//	sqlite3_close(database);
//	return value;
//}
