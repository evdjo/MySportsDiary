//
//  SQLiteDataManagerDelegate.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 13/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation

internal func insertEntry(entry: Entry) {
	let db: COpaquePointer! = openDB(DB_FILE_URL);
	guard db != nil else { return }
	guard createTable(db, create: ENTRIES_TABLE_CREATE) else { return }
	guard createTable(db, create: PHOTOS_TABLE_CREATE) else { return }
	var statement: COpaquePointer = nil;

	if (SQLITE_OK == sqlite3_prepare_v2(db, ENTRIES_INSERT, -1, &statement, nil)) {
		sqlite3_bind_text(statement, 1, entry.date_time, -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 2, entry.skill, -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 3, entry.description, -1, SQLITE_TRANSIENT);
		sqlite3_bind_double(statement, 4, entry.latitude);
		sqlite3_bind_double(statement, 5, entry.longitude);
	}

	if (SQLITE_DONE != sqlite3_step(statement)) {
		print("Error inserting entry!");
		sqlite3_close(db);
		return;
	}
	sqlite3_finalize(statement);
	statement = nil;

	let key = sqlite3_last_insert_rowid(db);

	if let photos = entry.photos {
		for i in 0 ... photos.count - 1 {
			if (SQLITE_OK == sqlite3_prepare_v2(db, PHOTOS_INSERT, -1, &statement, nil)) {
				sqlite3_bind_text(statement, 1, photos[i], -1, SQLITE_TRANSIENT)
				sqlite3_bind_int64(statement, 2, key)
			}
			if (sqlite3_step(statement) != SQLITE_DONE) {
				print("Error inserting image.");
			}
			sqlite3_finalize(statement);
		}
	}

	sqlite3_close(db);
}

internal func entries() -> [Entry]? {
	let db: COpaquePointer! = openDB(DB_FILE_URL);
	guard db != nil else { return nil; }
	guard createTable(db!, create: ENTRIES_TABLE_CREATE) else { return nil }
	var statement: COpaquePointer = nil;
	var photosStatement: COpaquePointer = nil;

	var entriesArray = Array<Entry>();
	if (sqlite3_prepare_v2(db, ENTRIES_SELECT, -1, &statement, nil) == SQLITE_OK) {
		while sqlite3_step(statement) == SQLITE_ROW {
			let event_id = sqlite3_column_int64(statement, 0)
			let date_time = dbString(sqlite3_column_text(statement, 1));
			let skill = dbString(sqlite3_column_text(statement, 2));
			let description = dbString(sqlite3_column_text(statement, 3));
			let lat = sqlite3_column_double(statement, 4);
			let lon = sqlite3_column_double(statement, 5);

			var photos = Array<String>();
			if (sqlite3_prepare_v2(db, PHOTOS_SELECT, -1, &photosStatement, nil) == SQLITE_OK) {
				sqlite3_bind_int64(photosStatement, 1, event_id)
				while sqlite3_step(photosStatement) == SQLITE_ROW {
					let photo = dbString(sqlite3_column_text(photosStatement, 0))
					if photo != "" { photos.append(photo); }
				}
			}

			let entry: Entry = Entry(skill: skill, description: description,
				date_time: date_time, latitude: lat, longitude: lon,
				photos: photos.count > 0 ? photos : nil, audio: nil, video: nil);

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
