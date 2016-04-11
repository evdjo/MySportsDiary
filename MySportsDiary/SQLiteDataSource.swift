//
//  SQLiteDataManagerDelegate.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 13/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation

let SQLITE_STATIC = unsafeBitCast(0, sqlite3_destructor_type.self)
let SQLITE_TRANSIENT = unsafeBitCast(-1, sqlite3_destructor_type.self)

let DB_NAME = "entries.db";

let ENTRIES_TABLE_NAME = "ENTRIES";

let ENTRIES_TABLE_CREATE = "CREATE TABLE IF NOT EXISTS ENTRIES (EVENT_ID INTEGER PRIMARY KEY, DATE_TIME TEXT, SKILL TEXT, DESCRIPTION TEXT, LOCATION_LON REAL, LOCATION_LAT REAL);";
let ENTRIES_INSERT = "INSERT INTO ENTRIES (EVENT_ID, DATE_TIME, SKILL, DESCRIPTION, LOCATION_LON, LOCATION_LAT) VALUES(NULL, ?, ?, ?, ?, ?);";
let ENTRIES_SELECT = "SELECT EVENT_ID, DATE_TIME, SKILL, DESCRIPTION, LOCATION_LON, LOCATION_LAT FROM ENTRIES ORDER BY EVENT_ID;"

let PHOTOS_TABLE_NAME = "PHOTOS";
let PHOTOS_TABLE_CREATE = "CREATE TABLE IF NOT EXISTS \(PHOTOS_TABLE_NAME)("
	+ "PHOTO_ID INTEGER PRIMARY KEY, "
	+ "PATH TEXT, "
	+ "ENTRY_ID INTEGER, "
	+ "FOREIGN KEY(ENTRY_ID) REFERENCES ENTRIES(EVENT_ID)"
	+ ");";
let PHOTOS_INSERT = "INSERT INTO PHOTOS (PHOTO_ID, PATH, ENTRY_ID) VALUES(NULL, ?, ?);"
let PHOTOS_SELECT = "SELECT PATH FROM PHOTOS WHERE ENTRY_ID = (?)  ORDER BY PHOTO_ID"

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

internal func createTable(db: COpaquePointer, create: String) -> Bool {
	var errMsg: UnsafeMutablePointer<Int8> = nil;
	let result = sqlite3_exec(db, create, nil, nil, &errMsg);
	if (result != SQLITE_OK) {
		print("creating user table has failed");
		sqlite3_close(db);
		return false;
	}
	return true;
}

internal func insertEntry(entry: Entry) {

	let db: COpaquePointer! = openEntriesDB();
	guard db != nil else { return; }
	guard createTable(db!, create: ENTRIES_TABLE_CREATE) else { return }
	guard createTable(db!, create: PHOTOS_TABLE_CREATE) else { return }

	var statement: COpaquePointer = nil;
	let status = sqlite3_prepare_v2(db, ENTRIES_INSERT, -1, &statement, nil);
	if (status == SQLITE_OK) {
		sqlite3_bind_text(statement, 1, entry.date_time, -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 2, entry.skill, -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 3, entry.description, -1, SQLITE_TRANSIENT);
		sqlite3_bind_double(statement, 4, entry.latitude);
		sqlite3_bind_double(statement, 5, entry.longitude);
	}

	if (sqlite3_step(statement) != SQLITE_DONE) {
		print("Error updating table");
		sqlite3_close(db);return;
	}

	let key = sqlite3_last_insert_rowid(db);
	sqlite3_finalize(statement);

	if let photos = entry.photos {

		for i in 0 ... photos.count - 1 {
			let status_2 = sqlite3_prepare_v2(db, PHOTOS_INSERT, -1, &statement, nil);
			if (status_2 == SQLITE_OK) {
				sqlite3_bind_text(statement, 1, photos[i], -1, SQLITE_TRANSIENT)
				sqlite3_bind_int64(statement, 2, key)
			}
			if (sqlite3_step(statement) != SQLITE_DONE) {
				print("Error updating table");
				sqlite3_close(db);return;
			}

			sqlite3_finalize(statement);
		}
	}

	sqlite3_close(db);
}

internal func entries() -> [Entry]? {
	let db: COpaquePointer! = openEntriesDB();
	guard db != nil else { return nil; }
	guard createTable(db!, create: ENTRIES_TABLE_CREATE) else { return nil }

	var statement: COpaquePointer = nil;

	var entriesArray = Array<Entry>();
	if (sqlite3_prepare_v2(db, ENTRIES_SELECT, -1, &statement, nil) == SQLITE_OK) {
		while sqlite3_step(statement) == SQLITE_ROW {
			let event_id = sqlite3_column_int64(statement, 0)
			let date_time = String.fromCString(
				UnsafePointer<CChar>(sqlite3_column_text(statement, 1))) ?? "";

			let skill = String.fromCString(
				UnsafePointer<CChar>(sqlite3_column_text(statement, 2))) ?? "";

			let description = String.fromCString(
				UnsafePointer<CChar>(sqlite3_column_text(statement, 3))) ?? "";

			let lat = sqlite3_column_double(statement, 4);
			let lon = sqlite3_column_double(statement, 5);

			var photos = Array<String>();
			var statement2: COpaquePointer = nil;
			if (sqlite3_prepare_v2(db, PHOTOS_SELECT, -1, &statement2, nil) == SQLITE_OK) {
				sqlite3_bind_int64(statement2, 1, event_id)
				while sqlite3_step(statement2) == SQLITE_ROW {
					if let photo = String.fromCString(
						UnsafePointer<CChar>(sqlite3_column_text(statement2, 0))) {
							photos.append(photo);
					}
				}
			}

			let entry: Entry = Entry(skill: skill,
				description: description,
				date_time: date_time,
				latitude: lat,
				longitude: lon,
				photos: photos.count > 0 ? photos : nil,
				audio: nil,
				video: nil)

			entriesArray.append(entry);
		}
	}
	sqlite3_finalize(statement);
	sqlite3_close(db);
	return entriesArray;
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
//
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
