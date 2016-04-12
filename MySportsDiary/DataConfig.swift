//
//  DBConfig_1.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 12/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation

///
/// THE ENTRIES DB FILE
///
let DB_NAME = "entries.sqlite";
let DB_LOCATION: NSSearchPathDirectory = .LibraryDirectory;
let DB_URL = fileURL(file: DB_NAME, under: DB_LOCATION);

/// AGE AND GENDER FILE
let USER_PROP_NAME = "userinfo.plist";
let USER_PROP_LOCATION: NSSearchPathDirectory = .LibraryDirectory
let USER_PROP_URL = fileURL(file: USER_PROP_NAME, under: USER_PROP_LOCATION);
let USER_AGE_KEY = "AGE";
let USER_GENDER_KEY = "GENDER";

/// QUESTIONNAIRE ANSWERS
let ANSWERS_NAME = "answerstemp.plist";
let ANSWERS_LOCATION: NSSearchPathDirectory = .LibraryDirectory
let ANSWERS_URL = fileURL(file: ANSWERS_NAME, under: ANSWERS_LOCATION);

/// APPLICATION STATE
let APP_PROP_NAME = "appproperties.plist";
let APP_PROP_LOCATION: NSSearchPathDirectory = .LibraryDirectory
let APP_PROP_URL = fileURL(file: APP_PROP_NAME, under: APP_PROP_LOCATION)
let APP_STATE_KEY = "APP_STATE";

///  TEMP MEDIA
let TEMP_DIR_LOCATION: NSSearchPathDirectory = .CachesDirectory
let TEMP_DIR_URL = createSubDir(dir: "temp_media", under: TEMP_DIR_LOCATION);
let TEMP_IMAGES_URL = createSubDirUnderParent(dir: "temp_images", parent: TEMP_DIR_URL);
let TEMP_AUDIO_URL = fileURLUnderParent(file: "temp_audio.caf", parent: TEMP_DIR_URL);
let TEMP_VIDEO_URL = fileURLUnderParent(file: "temp_video.MOV", parent: TEMP_DIR_URL)
