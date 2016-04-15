//
//  SQLiteDataManagerDelegate.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 13/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation

class SQLiteDBManager {
	static func insertEntry(entry: Entry) {
		let db: COpaquePointer! = openDB(DB_URL);
		guard db != nil else { return }
		guard createTable(db, create: ENTRIES_TABLE_CREATE) else { return }
		guard createTable(db, create: PHOTOS_TABLE_CREATE) else { return }
		var statement: COpaquePointer = nil;

		if (SQLITE_OK == sqlite3_prepare_v2(db, ENTRIES_INSERT, -1, &statement, nil)) {
			sqlite3_bind_text(statement, 1, entry.date_time, -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(statement, 2, entry.skill, -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(statement, 3, entry.description, -1, SQLITE_TRANSIENT);
			if let audio = entry.audio {
				sqlite3_bind_text(statement, 4, audio, -1, SQLITE_TRANSIENT);
			} else {
				sqlite3_bind_null(statement, 4);
			}
			if let video = entry.video {
				sqlite3_bind_text(statement, 5, video, -1, SQLITE_TRANSIENT);
			} else {
				sqlite3_bind_null(statement, 5);
			}
			sqlite3_bind_double(statement, 6, entry.latitude);
			sqlite3_bind_double(statement, 7, entry.longitude);
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

	static func entries() -> [Entry]? {
		let db: COpaquePointer! = openDB(DB_URL);
		guard db != nil else { return nil; }
		guard createTable(db!, create: ENTRIES_TABLE_CREATE) else { return nil }
		var statement: COpaquePointer = nil;
		var photosStatement: COpaquePointer = nil;

		var entriesArray = Array<Entry>();
		if (sqlite3_prepare_v2(db, ENTRIES_SELECT, -1, &statement, nil) == SQLITE_OK) {
			while sqlite3_step(statement) == SQLITE_ROW {
				let entry_id = sqlite3_column_int64(statement, 0)
				let date_time = dbString(sqlite3_column_text(statement, 1)) ?? "Bad date time";
				let skill = dbString(sqlite3_column_text(statement, 2)) ?? "Bad skill";
				let description = dbString(sqlite3_column_text(statement, 3)) ?? "Bad description";
				let audio = dbString(sqlite3_column_text(statement, 4));
				let video = dbString(sqlite3_column_text(statement, 5));
				let lat = sqlite3_column_double(statement, 6);
				let lon = sqlite3_column_double(statement, 7);

				var photos = Array<String>();
				if (sqlite3_prepare_v2(db, PHOTOS_SELECT, -1, &photosStatement, nil) == SQLITE_OK) {
					sqlite3_bind_int64(photosStatement, 1, entry_id)
					while sqlite3_step(photosStatement) == SQLITE_ROW {
						if let photo = dbString(sqlite3_column_text(photosStatement, 0)) {
							photos.append(photo);
						}
					}
				}

				let entry: Entry = Entry(entry_id: entry_id, skill: skill, description: description,
					date_time: date_time, latitude: lat, longitude: lon,
					photos: photos.count > 0 ? photos : nil, audio: audio, video: video);
				entriesArray.append(entry);
			}
		}
		sqlite3_finalize(statement);
		sqlite3_close(db);
		return entriesArray.count > 0 ? entriesArray : nil;
	}

	static func entryForID(entry_id: Int64) -> Entry? {
		let db: COpaquePointer! = openDB(DB_URL);
		guard db != nil else { return nil; }
		guard createTable(db!, create: ENTRIES_TABLE_CREATE) else { return nil }
		var statement: COpaquePointer = nil;
		var photosStatement: COpaquePointer = nil;

		var entry: Entry?;
		if (sqlite3_prepare_v2(db, ENTRY_WITH_ID_SELECT, -1, &statement, nil) == SQLITE_OK) {
			sqlite3_bind_int64(statement, 1, entry_id)
			if sqlite3_step(statement) == SQLITE_ROW {
				// let entry_id = sqlite3_column_int64(statement, 0)
				let date_time = dbString(sqlite3_column_text(statement, 1)) ?? "Bad date time";
				let skill = dbString(sqlite3_column_text(statement, 2)) ?? "Bad skill";
				let description = dbString(sqlite3_column_text(statement, 3)) ?? "Bad description";
				let audio = dbString(sqlite3_column_text(statement, 4));
				let video = dbString(sqlite3_column_text(statement, 5));
				let lat = sqlite3_column_double(statement, 6);
				let lon = sqlite3_column_double(statement, 7);

				var photos = Array<String>();
				if (sqlite3_prepare_v2(db, PHOTOS_SELECT, -1, &photosStatement, nil) == SQLITE_OK) {
					sqlite3_bind_int64(photosStatement, 1, entry_id)
					while sqlite3_step(photosStatement) == SQLITE_ROW {
						if let photo = dbString(sqlite3_column_text(photosStatement, 0)) {
							photos.append(photo);
						}
					}
				}

				entry = Entry(entry_id: entry_id, skill: skill, description: description,
					date_time: date_time, latitude: lat, longitude: lon,
					photos: photos.count > 0 ? photos : nil, audio: audio, video: video);
			}
		}
		sqlite3_finalize(statement);
		sqlite3_close(db);
		return entry;
	}

	static func purgeDB() { deleteFile(file: DB_URL) }
}
