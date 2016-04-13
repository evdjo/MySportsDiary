//
//  DBConfig.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 12/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation

////
/// Master folder
//
let MASTER_DIR_LOCATION: NSSearchPathDirectory = .LibraryDirectory
let MASTER_DIR_URL = createSubDir(dir: "DiaryData", under: MASTER_DIR_LOCATION);

////
/// THE ENTRIES DB FILE
//
let DB_NAME = "entries.sqlite";
let DB_LOCATION: NSSearchPathDirectory = .LibraryDirectory;
let DB_URL = fileURLUnderParent(file: DB_NAME, parent: MASTER_DIR_URL);

////
/// AGE AND GENDER FILE
//
let USER_PROP_NAME = "userinfo.plist";
let USER_PROP_LOCATION: NSSearchPathDirectory = .LibraryDirectory
let USER_PROP_URL = fileURLUnderParent(file: USER_PROP_NAME, parent: MASTER_DIR_URL);
let USER_AGE_KEY = "AGE";
let USER_GENDER_KEY = "GENDER";

////
/// QUESTIONNAIRE ANSWERS
//
let ANSWERS_NAME = "answerstemp.plist";
let ANSWERS_LOCATION: NSSearchPathDirectory = .LibraryDirectory
let ANSWERS_URL = fileURLUnderParent(file: ANSWERS_NAME, parent: MASTER_DIR_URL);

////
/// APPLICATION STATE
//
let APP_PROP_NAME = "appproperties.plist";
let APP_PROP_LOCATION: NSSearchPathDirectory = .LibraryDirectory
let APP_PROP_URL = fileURLUnderParent(file: APP_PROP_NAME, parent: MASTER_DIR_URL);
let APP_STATE_KEY = "APP_STATE";

////
///  TEMP MEDIA
//
let TEMP_DIR_LOCATION: NSSearchPathDirectory = .CachesDirectory
let TEMP_DIR_URL = createSubDir(dir: "temp_media", under: TEMP_DIR_LOCATION);
let TEMP_IMAGES_URL = createSubDirUnderParent(dir: "temp_images", parent: TEMP_DIR_URL);
let TEMP_AUDIO_URL = fileURLUnderParent(file: "temp_audio.caf", parent: TEMP_DIR_URL);
let TEMP_VIDEO_URL = fileURLUnderParent(file: "temp_video.MOV", parent: TEMP_DIR_URL);
