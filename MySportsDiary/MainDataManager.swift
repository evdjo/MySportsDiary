//
//  MainDataManager.swift
//  MyRugbyDiary
//
//  Created by Evdzhan Mustafa on 31/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation
import UIKit

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

///
///
/// Handles all persistent data, such as user Age, Gender, Questionnaire Answers,
/// Entries
///
///
/// The actual implementation is usually delegated to helper classes.
///
private class MainDataManager: DataManager {
	private init() { };
	func getAge() -> Int? { return UserProperties.getAge(); }
	func getGender() -> Gender? { return UserProperties.getGender(); }
	
	func setAge(age: Int) { UserProperties.setAge(age); }
	func setGender(gender: Gender) { UserProperties.setGender(gender); }
	
	func setAnswer(questionID: Int, answer: Int, forState: ApplicationState) {
		Questionnaire.setAnswer(questionID, answer: answer, forState: forState);
	}
	func getAnswer(questionID: Int, forState: ApplicationState) -> Int? {
		return Questionnaire.getAnswer(questionID, forState: forState);
	}
	
	func setAppState(appState: ApplicationState) {
		AppProperties.setAppState(appState);
	}
	func getAppState() -> ApplicationState? {
		return AppProperties.getAppState();
	}
	
	func setDiaryEndDate(dateString: String) {
		AppProperties.setDiaryEndDate(dateString); }
	func getDiaryEndDate() -> String? {
		return AppProperties.getDiaryEndDate();
	}
	
	func getImages(imagesURL: NSURL) -> Array<UIImage>? {
		return ImagesIO.getImages(imagesURL);
	}
	
	func saveImage(imagesURL: NSURL, image: UIImage) {
		ImagesIO.saveImage(imagesURL, image: image);
	}
	func removeImage(imagesURL: NSURL, index: Int) {
		ImagesIO.removeImage(imagesURL, index: index);
	}
	func getImagesCount(imagesURL: NSURL) -> Int {
		return ImagesIO.getImagesCount(imagesURL);
	}
	func getVideo(oldVideo videoURL: NSURL) -> NSURL? {
		return VideoIO.getVideo(oldVideo: videoURL);
	}
	func setVideo(oldVideo videoURL: NSURL, newVideo newVideoURL: NSURL?) {
		VideoIO.setVideo(oldVideo: videoURL, newVideo: newVideoURL);
	}
	func getAudio(oldAudio audioURL: NSURL) -> NSURL? {
		return AudioIO.getAudio(oldAudio: audioURL);
	}
	func setAudio(oldAudio audioURL: NSURL, newAudio newAudioURL: NSURL?) {
		AudioIO.setAudio(oldAudio: audioURL, newAudio: newAudioURL);
	}
///
/// Add a new entry to the database.
/// Move the  temp files underneath current temp folder.
/// Recreate those folders.
///
	func addNewEntry(entry: Entry) {
		EntriesDB.insertEntry(entry);
		let dir = fileURLUnderParent(file: entry.date_time,
			parent: DataConfig.ENTRIES_DIR_URL);
		
		myMove(DataConfig.TEMP_DIR_URL, toPath: dir);
		
		createSubDir(dir: DataConfig.TEMP_MEDIA,
			under: DataConfig.TEMP_DIR_LOCATION)
		
		createSubDirUnderParent(dir: DataConfig.IMAGES,
			parent: DataConfig.TEMP_DIR_URL)
	}
///
/// Get all from the DB entries
///
	func getEntries() -> [Entry]? {
		return EntriesDB.entries();
	}
///
/// Get the entries structured by the TODAY, THIS WEEK, and OLDER
///
	func getEntriesByDate() -> EntriesByDate {
		return EntriesByDate(entries: EntriesDB.entries());
	}
	
///
/// Delete an entry with the specified entry_id
///
	func deleteEntryWithID(entry_id: Int64) {
		let entry = EntriesDB.entryForID(entry_id);
		if let entry = entry {
			deleteFile(file: DataConfig.ENTRIES_DIR_URL
					.URLByAppendingPathComponent(entry.date_time));
			
			EntriesDB.deleteEntryWithID(entry_id)
		}
	}
///
/// Get the entry with the specified entry_id
///
	func getEntryForID(entry_id: Int64) -> Entry? {
		return EntriesDB.entryForID(entry_id);
	}
	
///
/// Update the entry with the specified entry_id
///
	func updateEntryWithID(id id: Int64, newDescr: String) {
		EntriesDB.updateEntryWithID(id: id, newDescr: newDescr);
	}
///
/// Deletes all contents in the app
///
	func purgeAllData() {
		purgeUserData();
		purgeAppData();
		purgeQuestionnaireAnswers();
		purgeTempMedia();
		purgeEntries();
		DataConfig.resetDirs();
	}
///
/// Deletes the stored age and gender values of the user.
///
	func purgeUserData() {
		UserProperties.purgeData();
		DataConfig.resetDirs();
	}
///
/// Resets the apps state to .Initial, and the diary end date.
///
	func purgeAppData() {
		AppProperties.purgeData();
		DataConfig.resetDirs();
	}
///
/// Deletes the answer provided by the user
///
	func purgeQuestionnaireAnswers() {
		Questionnaire.purgeData();
		DataConfig.resetDirs();
	}
///
/// Deletes the entries database file, along with the entries folder
///
	func purgeEntries() {
		EntriesDB.purgeEntries();
		DataConfig.resetDirs();
	}
///
/// Purges the temp media
///
	func purgeTempMedia() {
		ImagesIO.purgeImages(DataConfig.TEMP_DIR_URL);
		AudioIO.purgeAudio(oldAudio: DataConfig.TEMP_DIR_URL);
		VideoIO.purgeVideo(oldVideo: DataConfig.TEMP_DIR_URL);
	}
///
/// Creates dummy entries
///
	func generateDummyEntries() {
		self.addNewEntry(dummyEntry(days: 0))
		self.addNewEntry(dummyEntry(days: 3))
		self.addNewEntry(dummyEntry(days: 10))
	}
}