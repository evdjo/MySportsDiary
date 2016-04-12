//
//  File.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 13/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation
import UIKit

///
/// Handles all persistent data, such as user Age, Gender, Questionnaire Answers, Events
///

private var instance: DataManager? = nil;

internal func DataManagerInstance() -> DataManager {
	if instance == nil {
		instance = MainDataManager();
	}
	return instance!;
}

protocol DataManager {

	func getAge() -> Int?;
	func getGender() -> Gender?;
	func setAge(age: Int);
	func setGender(gender: Gender);

	func setAnswer(questionID: Int, answer: Int);
	func getAnswer(questionID: Int) -> Int?;

	func getAppState() -> ApplicationState?;
	func setAppState(appState: ApplicationState);

	func getTempImages() -> [UIImage]?;
	func getImagesCount() -> Int;
	func saveTempImage(image: UIImage);
	func removeTempImage(index: Int);
	// func moveTempImages(toDir dir: String) -> NSURL;

	func getTempVideo() -> NSURL?;
	func setTempVideo(videoURL: NSURL?);

	func getTempAudio() -> (url: NSURL, exists: Bool);
	func setTempAudio(audioURL: NSURL?);

	func addNewEntry(entry: Entry);

	func getEntries() -> [Entry]?
	func getEntryForID(entry_id: Int64) -> Entry?;

	/// CAUTION --- deletes ALL DATA!
	func purgeAllData();
	/// CAUTION --- deletes AGE AND GENDER !
	func purgeUserData();
	/// CAUTION --- deletes APP PROPERTIES !
	func purgeAppData();
	/// CAUTION --- deletes the QUESTIONNAIRE ANSWERS !
	func purgeQuestionnaireAnswers();
	/// CAUTION --- deletes the PHOTOS/VIDEO/AUDIO TEMP FILES !
	func purgeTempMedia();
	/// CAUTION --- deletes the ENTRIES DATABASE FILE !
	func purgeEntriesDB();
}
