//
//  EventTabUtil.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 05/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//
import UIKit
import Foundation
//"The device does have photo library."
let NO_LIBRARY = NSLocalizedString("NO_LIBRARY",
	comment: "Text explaining that the device does not have a library.");

// "The device does have camera."
let NO_CAMERA = NSLocalizedString("NO_CAMERA",
	comment: "Text explaining that the device does not have a camera");

//"You've denied permission of this app to use the photo library. You can grant permission in the settings menu."
let LIBRARY_PERMISSION_DENIED = NSLocalizedString("LIBRARY_PERMISSION_DENIED",
	comment: "Text explaining that the user has denied this app to use his library");

// "You've denied permission of this app to use the camera device. You can grant permission in the settings menu."
let CAMERA_PERMISSION_DENIED = NSLocalizedString("CAMERA_PERMISSION_DENIED",
	comment: "Text explaining that the user has denied this app to use the camera");

// "Go to settings"
let GO_TO_SETTINGS = NSLocalizedString("GO_TO_SETTINGS",
	comment: "Text offering the user to go to the settgins of the app");

//  "Cannot access your library.
let NO_LIBRARY_ACCESS = NSLocalizedString("NO_LIBRARY_ACCESS",
	comment: "Text explaining that there is  no access to the user's library");

// "Cannot access your camera."
let NO_CAMERA_ACCESS = NSLocalizedString("NO_CAMERA_ACCESS",
	comment: "Text explaining that the camera cannot be accessed on this device");

// "Delete photo?"
let DELETE_THE_PHOTO = NSLocalizedString("DELETE_THE_PHOTO",
	comment: "Question asking confirmation to delete the photo");

// "Delete video?"
let DELETE_THE_VIDEO = NSLocalizedString("DELETE_THE_VIDEO",
	comment: "Question asking confirmation to delete the video");

// "Yes"
let YES = NSLocalizedString("YES", comment: "The positive answer -- Yes");

// "No"
let NO = NSLocalizedString("NO", comment: "The negative answer -- Yes");

// "Cancel";
let CANCEL = NSLocalizedString("CANCEL", comment: "The canceling button label -- Cancel");

// "Failed to record."
let FAILED_TO_RECORD = NSLocalizedString("FAILED_TO_RECORD",
	comment: "Text explaining that the recording has failed");

// "play"
let PLAY = NSLocalizedString("PLAY",
	comment: "Text indicating that pressing the button will play the voice recording");

// "stop"
let STOP = NSLocalizedString("STOP",
	comment: "Text indicating that pressing the button will stop the playback of the recording");

// "record"
let RECORD = NSLocalizedString("RECORD",
	comment: "Text indicating that pressing the button will start recording a voice");

// "Done"
let DONE = NSLocalizedString("DONE", comment:
		"Text for a button indicating that pressing it will complete some action");

var NEW_ENTRY_TEXT_1 = NSLocalizedString("NEW_ENTRY_TEXT_1",
	comment: "The text to prompt the user describe the skill he is recording. This text appears before the skill. For example, if we have  this string equal to \"Today I showed\", and NEW_ENTRY_TEXT_2  equal to \"because of rugby.\", then we get the sentence:  Today I showed SKILL because of rugby. One of the strings can be ommited if it makes logical sentences in the target language.")

var NEW_ENTRY_TEXT_2 = NSLocalizedString("NEW_ENTRY_TEXT_2",
	comment: "See NEW_ENTRY_TEXT_1 ")

var ENTER_TEXT = NSLocalizedString("ENTER_TEXT",
	comment: "Text description to appear in the entry description text area.")

var ADD_PHOTO = NSLocalizedString("ADD_PHOTO", comment: "Short text promting addition of a photo");

var ADD_VOICE = NSLocalizedString("ADD_VOICE", comment: "Short text promting addition of a voice");

var ADD_VIDEO = NSLocalizedString("ADD_VIDEO", comment: "Short text promting addition of a video");

// "added voice"
var ADDED_VOICE = NSLocalizedString("ADDED_VOICE",
	comment: "Indicate that there is voice added, and selecting the button will show the audio");
// "added photo"
var ADDED_PHOTO = NSLocalizedString("ADDED_PHOTO",
	comment: "Indicate that there are photos added, and selecting the button will show the photos");

// "added video"
var ADDED_VIDEO = NSLocalizedString("ADDED_VIDEO",
	comment: "Indicate that there is video added, and selecting the button will show the video");

// "OK"
var OK = NSLocalizedString("OK", comment: "An OK confirmation -- OK");

// "Next"
var NEXT = NSLocalizedString("NEXT", comment: "Next button title");

// "Finish"
var FINISH = NSLocalizedString("FINISH", comment: "Finish button title");

// "Are you sure?"
var ARE_YOU_SURE = NSLocalizedString("ARE_YOU_SURE", comment: "Ask the user if he is sure");

// "You cannot change your answers later".
var FINISH_QUESTIONNAIRE_CONFIRM = NSLocalizedString("FINISH_QUESTIONNAIRE_CONFIRM",
	comment: "The message below the prompt of ARE_YOU_SURE");

let questions = [
	NSLocalizedString("QUESTION_1", comment: "I do well at any sports I play"),
	NSLocalizedString("QUESTION_2", comment: "I am happy to be me"),
	NSLocalizedString("QUESTION_3", comment: "I get angry often"),
	NSLocalizedString("QUESTION_4", comment: "I hit people if they start the fight"),
	NSLocalizedString("QUESTION_5", comment: "I accept responsibility for my behaviour if I make a mistake"),
	NSLocalizedString("QUESTION_6", comment: "I do very well in my school work"),
	NSLocalizedString("QUESTION_7", comment: "I use my imagination to solve problems"),
	NSLocalizedString("QUESTION_8", comment: "I want to help to make my community a better place to live"),
	NSLocalizedString("QUESTION_9", comment: "I feel important in my community"),
]

let WELCOME_STRING = NSLocalizedString("WELCOME_STRING",
	comment: "Welcome the user, by telling him that he has to answer few questions");

let DIARY_TEXT = NSLocalizedString("DIARY_TEXT",
	comment: "Tell the user that he has unlocked the diary, and he can add entries to it.");

let FINAL_TEXT = NSLocalizedString("FINAL_TEXT",
	comment: "Tell the user he has to answer the questionnaire again");
// "Now you must answer the final questionnaire.";

let DIARY_DATE_TEXT = NSLocalizedString("DIARY_DATE_TEXT",
	comment: "String to tell the user that he will answer the questionnaire again at the end");
// "You will answer the questionnaire again on"

