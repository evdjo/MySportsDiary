//
//  SQLiteDataManagerDelegate.swift
//  MyRugbyDiary
//
//  Created by Evdzhan Mustafa on 13/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation

class EntriesDB {
	///
	/// Insert a entry to the entries data base.
	///
	static func insertEntry(entry: Entry) {
		let db: COpaquePointer! = openDB(DataConfig.DB_URL);
		guard db != nil else { return }
		guard createTable(db, create: ENTRIES_TABLE_CREATE) else { return }
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
		sqlite3_close(db);
	}

	///
	/// Get all entries from the entries database.
	/// Will return nil if there are no entries added.
	///
	static func entries() -> [Entry]? {
		let db: COpaquePointer! = openDB(DataConfig.DB_URL);
		guard db != nil else { return nil; }
		guard createTable(db!, create: ENTRIES_TABLE_CREATE) else { return nil }
		var statement: COpaquePointer = nil;

		var entriesArray = Array<Entry>();
		if (sqlite3_prepare_v2(db, ENTRIES_SELECT, -1, &statement, nil) == SQLITE_OK) {
			while sqlite3_step(statement) == SQLITE_ROW {
				let entry_id = sqlite3_column_int64(statement, 0)
				let date_time = dbString(sqlite3_column_text(statement, 1)) ?? "Bad date time";
				let skill = dbString(sqlite3_column_text(statement, 2)) ?? "Bad skill";
				let description = dbString(sqlite3_column_text(statement, 3)) ?? "Bad description";
				let lat = sqlite3_column_double(statement, 4);
				let lon = sqlite3_column_double(statement, 5);

				let entry: Entry = Entry(entry_id: entry_id,
					skill: skill,
					description: description,
					date_time: date_time,
					latitude: lat,
					longitude: lon);

				entriesArray.append(entry);
			}
		}
		sqlite3_finalize(statement);
		sqlite3_close(db);
		return entriesArray.count > 0 ? entriesArray : nil;
	}

	///
	/// Returns the entry with the passed entry_id if it is in the db,
	/// else nil
	///
	static func entryForID(entry_id: Int64) -> Entry? {
		let db: COpaquePointer! = openDB(DataConfig.DB_URL);
		guard db != nil else { return nil; }
		guard createTable(db!, create: ENTRIES_TABLE_CREATE) else { return nil }
		var statement: COpaquePointer = nil;
		var entry: Entry?;
		if (sqlite3_prepare_v2(db, ENTRY_WITH_ID_SELECT, -1, &statement, nil) == SQLITE_OK) {
			sqlite3_bind_int64(statement, 1, entry_id)
			if sqlite3_step(statement) == SQLITE_ROW {
				// let entry_id = sqlite3_column_int64(statement, 0)
				let date_time = dbString(sqlite3_column_text(statement, 1)) ?? "Bad date time";
				let skill = dbString(sqlite3_column_text(statement, 2)) ?? "Bad skill";
				let description = dbString(sqlite3_column_text(statement, 3)) ?? "Bad description";
				let lat = sqlite3_column_double(statement, 4);
				let lon = sqlite3_column_double(statement, 5);

				entry = Entry(entry_id: entry_id,
					skill: skill,
					description: description,
					date_time: date_time,
					latitude: lat,
					longitude: lon);
			}
		}
		sqlite3_finalize(statement);
		sqlite3_close(db);
		return entry;
	}

	///
	/// Delete the entry with the given ID
	///
	static func deleteEntryWithID(entry_id: Int64) {
		let db: COpaquePointer! = openDB(DataConfig.DB_URL);
		guard db != nil else { return; }
		guard createTable(db!, create: ENTRIES_TABLE_CREATE) else { return; }
		var statement: COpaquePointer = nil;
		if (sqlite3_prepare_v2(db, ENTRY_WITH_ID_DELETE, -1, &statement, nil) == SQLITE_OK) {
			sqlite3_bind_int64(statement, 1, entry_id)
			if SQLITE_DONE == sqlite3_step(statement) {
				print("Entry deleted");
			}
		}
		sqlite3_finalize(statement);
		sqlite3_close(db);
	}

	///
	/// Updates the description of the entry with the passed id.
	///
	static func updateEntryWithID(id id: Int64, newDescr: String) {
		let db: COpaquePointer! = openDB(DataConfig.DB_URL);
		guard db != nil else { return }
		guard createTable(db, create: ENTRIES_TABLE_CREATE) else { return }
		var statement: COpaquePointer = nil;

		if (SQLITE_OK == sqlite3_prepare_v2(db, ENTRY_UPDATE, -1, &statement, nil)) {
			sqlite3_bind_text(statement, 1, newDescr, -1, SQLITE_TRANSIENT);
			sqlite3_bind_int64(statement, 2, id);
		}

		if (SQLITE_DONE != sqlite3_step(statement)) {
			print("Error updating entry!");
			sqlite3_close(db);
			return;
		}
		sqlite3_finalize(statement);
		statement = nil;
		sqlite3_close(db);
	}

	///
	/// Deletes all entrties, by delete the entries database
	/// and the entries folder.
	///
	static func purgeEntries() {
		deleteFile(file: DataConfig.DB_URL);
		deleteFile(file: DataConfig.ENTRIES_DIR_URL);
	}
}
