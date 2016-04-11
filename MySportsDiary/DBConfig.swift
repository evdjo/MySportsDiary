//
//  DBConfig.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 11/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation

///
/// <---------- CONFIGURE WHERE THE DB RESIDES ---------->
///
let DB_NAME = "entries.sqlite";
let DB_LOCATION: NSSearchPathDirectory = .LibraryDirectory;
let DB_FILE_URL = fileURL(file: DB_NAME, under: DB_LOCATION);

///
/// <---------- ENTRIES TABLE STATEMENTS ---------->
///
let ENTRIES_TABLE_NAME = "ENTRIES";
let ENTRIES_TABLE_CREATE = "CREATE TABLE IF NOT EXISTS ENTRIES"
	+ " (EVENT_ID INTEGER PRIMARY KEY,"
	+ " DATE_TIME TEXT, SKILL TEXT, DESCRIPTION TEXT,"
	+ " LOCATION_LON REAL, LOCATION_LAT REAL);";
let ENTRIES_INSERT = "INSERT INTO ENTRIES"
	+ " (EVENT_ID, DATE_TIME, SKILL, DESCRIPTION, LOCATION_LON, LOCATION_LAT)"
	+ " VALUES(NULL, ?, ?, ?, ?, ?);";
let ENTRIES_SELECT = "SELECT"
	+ " EVENT_ID, DATE_TIME, SKILL, DESCRIPTION, LOCATION_LON, LOCATION_LAT"
	+ " FROM ENTRIES ORDER BY EVENT_ID;"

///
/// <---------- PHOTOS TABLE STATEMENTS ---------->
///
let PHOTOS_TABLE_NAME = "PHOTOS";
let PHOTOS_TABLE_CREATE = "CREATE TABLE IF NOT EXISTS PHOTOS"
	+ "(PHOTO_ID INTEGER PRIMARY KEY,"
	+ " PATH TEXT, ENTRY_ID INTEGER,"
	+ " FOREIGN KEY(ENTRY_ID) REFERENCES ENTRIES(EVENT_ID));";
let PHOTOS_INSERT = "INSERT INTO PHOTOS"
	+ " (PHOTO_ID, PATH, ENTRY_ID) VALUES(NULL, ?, ?);"
let PHOTOS_SELECT = "SELECT PATH FROM PHOTOS"
	+ " WHERE ENTRY_ID = (?) ORDER BY PHOTO_ID"