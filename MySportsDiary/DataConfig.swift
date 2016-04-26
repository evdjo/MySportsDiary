//
//  DBConfig.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 12/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation

class DataConfig {
    
    // Mark:-
    // Mark: Reset and recreate dirs if needed.
	static func resetDirs() {
		if !fileExists(MASTER_DIR_URL) {
			MASTER_DIR_URL = createSubDir(dir: "DiaryData", under: MASTER_DIR_LOCATION);
		}
		if !fileExists(ENTRIES_DIR_URL) {
			ENTRIES_DIR_URL = createSubDirUnderParent(dir: ENTRIES_DIR_NAME, parent: MASTER_DIR_URL);
		}
		if !fileExists(TEMP_DIR_URL) {
			TEMP_DIR_URL = createSubDir(dir: TEMP_MEDIA, under: TEMP_DIR_LOCATION);
		}
		if !fileExists(TEMP_IMAGES_URL) {
			TEMP_IMAGES_URL = createSubDirUnderParent(dir: IMAGES, parent: TEMP_DIR_URL);
		}
	}
	
    // Mark:-
    // Mark: Master folder
	static let MASTER_DIR_LOCATION: NSSearchPathDirectory = .LibraryDirectory
	static var MASTER_DIR_URL = createSubDir(dir: "DiaryData", under: MASTER_DIR_LOCATION);
	
    // Mark:-
    // Mark: THE ENTRIES DB FILE
	static let DB_NAME = "entries.sqlite";
	static let DB_LOCATION: NSSearchPathDirectory = .LibraryDirectory;
	static let DB_URL = fileURLUnderParent(file: DB_NAME, parent: MASTER_DIR_URL);
	
	// Mark:-
	// Mark: ENTRIES DIRECTORY
	static let ENTRIES_DIR_NAME = "entries";
	static var ENTRIES_DIR_URL = createSubDirUnderParent(dir: ENTRIES_DIR_NAME, parent: MASTER_DIR_URL);
	
    // Mark:-
    // Mark:  AGE AND GENDER FILE
	static let USER_PROP_NAME = "userinfo.plist";
	static let USER_PROP_LOCATION: NSSearchPathDirectory = .LibraryDirectory
	static let USER_PROP_URL = fileURLUnderParent(file: USER_PROP_NAME, parent: MASTER_DIR_URL);
	static let USER_AGE_KEY = "AGE";
	static let USER_GENDER_KEY = "GENDER";
	
    // Mark:-
    // Mark: QUESTIONNAIRE ANSWERS
	static let ANSWERS_NAME_I = "answers_initial.plist"; // I for INITIAL
	static let ANSWERS_NAME_F = "answers_final.plist"; // F for FINAL
	static let ANSWERS_LOCATION: NSSearchPathDirectory = .LibraryDirectory
	static let ANSWERS_URL_I = fileURLUnderParent(file: ANSWERS_NAME_I, parent: MASTER_DIR_URL);
	static let ANSWERS_URL_F = fileURLUnderParent(file: ANSWERS_NAME_F, parent: MASTER_DIR_URL);
	
    // Mark:-
    // Mark: APPLICATION STATE
	static let APP_PROP_NAME = "appproperties.plist";
	static let APP_PROP_LOCATION: NSSearchPathDirectory = .LibraryDirectory
	static let APP_PROP_URL = fileURLUnderParent(file: APP_PROP_NAME, parent: MASTER_DIR_URL);
	static let APP_STATE_KEY = "APP_STATE";
	static let APP_DIARY_START = "APP_DIARY_START";
	
    // Mark:-
    // Mark: MEDIA FILE/FOLDER NAMES
	static let IMAGES = "images";
	static let AUDIO = "audio.caf";
	static let VIDEO = "video.MOV";
	static let TEMP_MEDIA = "temp_media";
    
    // Mark:-
    // Mark: TEMP MEDIA DIRS
    static let TEMP_DIR_LOCATION: NSSearchPathDirectory = .CachesDirectory
	static var TEMP_DIR_URL = createSubDir(dir: TEMP_MEDIA, under: TEMP_DIR_LOCATION);
	static var TEMP_IMAGES_URL = createSubDirUnderParent(dir: IMAGES, parent: TEMP_DIR_URL);
	static var TEMP_AUDIO_URL = fileURLUnderParent(file: AUDIO, parent: TEMP_DIR_URL);
	static var TEMP_VIDEO_URL = fileURLUnderParent(file: VIDEO, parent: TEMP_DIR_URL);
}
