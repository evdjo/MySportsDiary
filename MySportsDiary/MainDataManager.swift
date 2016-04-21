//
//  MainDataManager.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 31/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation
import UIKit

///
///
/// Handles all persistent data, such as user Age, Gender, Questionnaire Answers, Events
///
/// To ensure that only the DataMangerInstance method can manipulate the data,
/// moved the singleton implementation here.
///
private var instance: DataManager? = nil;

internal func DataManagerInstance() -> DataManager {
	if instance == nil {
		instance = MainDataManager();
	}
	return instance!;
}

private class MainDataManager: DataManager {
	private init() { };
	func getAge() -> Int? { return UserProperties.getAge(); }
	func getGender() -> Gender? { return UserProperties.getGender(); }
	func setAge(age: Int) { UserProperties.setAge(age); }
	func setGender(gender: Gender) { UserProperties.setGender(gender); }
	func setAnswer(questionID: Int, answer: Int) { Questionnaire.setAnswer(questionID, answer: answer); }
	func getAnswer(questionID: Int) -> Int? { return Questionnaire.getAnswer(questionID); }
	func setAppState(appState: ApplicationState) { AppProperties.setAppState(appState); }
	func getAppState() -> ApplicationState? { return AppProperties.getAppState(); }
	func setDiaryStart(dateString: String) { AppProperties.setDiaryStart(dateString); }
	func getDiaryStart() -> String? { return AppProperties.getDiaryStart(); }

	func getImages(imagesURL: NSURL) -> Array<UIImage>? { return ImagesIO.getImages(imagesURL); }
	func saveImage(imagesURL: NSURL, image: UIImage) { ImagesIO.saveImage(imagesURL, image: image); }
	func removeImage(imagesURL: NSURL, index: Int) { ImagesIO.removeImage(imagesURL, index: index); }
	func getImagesCount(imagesURL: NSURL) -> Int { return ImagesIO.getImagesCount(imagesURL); }
	func getVideo(oldVideo videoURL: NSURL) -> NSURL? { return VideoIO.getVideo(oldVideo: videoURL); }
	func setVideo(oldVideo videoURL: NSURL, newVideo newVideoURL: NSURL?) { VideoIO.setVideo(oldVideo: videoURL, newVideo: newVideoURL); }
	func getAudio(oldAudio audioURL: NSURL) -> NSURL? { return AudioIO.getAudio(oldAudio: audioURL); }
	func setAudio(oldAudio audioURL: NSURL, newAudio newAudioURL: NSURL?) { AudioIO.setAudio(oldAudio: audioURL, newAudio: newAudioURL); }

	func addNewEntry(entry: Entry) { EntriesDB.insertEntry(entry); }
	func getEntries() -> [Entry]? { return EntriesDB.entries(); }
	func getEntryForID(entry_id: Int64) -> Entry? { return EntriesDB.entryForID(entry_id); }
	func updateEntryWithID(id id: Int64, newDescr: String) { EntriesDB.updateEntryWithID(id: id, newDescr: newDescr); }

	func purgeAllData() {
		purgeUserData();
		purgeAppData();
		purgeQuestionnaireAnswers();
		purgeTempMedia();
		purgeEntries();
		DataConfig.resetDirs();
	}

	func purgeUserData() { UserProperties.purgeData(); }
	func purgeAppData() { AppProperties.purgeData(); }
	func purgeQuestionnaireAnswers() { Questionnaire.purgeData(); }
	func purgeEntries() { EntriesDB.purgeEntries(); }

	func purgeTempMedia() {
		ImagesIO.purgeImages(DataConfig.TEMP_DIR_URL);
		AudioIO.purgeAudio(oldAudio: DataConfig.TEMP_DIR_URL);
		VideoIO.purgeVideo(oldVideo: DataConfig.TEMP_DIR_URL);
	}
}