//
//  MainDataManager.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 31/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation
import UIKit

class MainDataManager: DataManager {
	internal init() { };
	func getAge() -> Int? { return UserProperties.getAge(); }
	func getGender() -> Gender? { return UserProperties.getGender(); }
	func setAge(age: Int) { UserProperties.setAge(age); }
	func setGender(gender: Gender) { UserProperties.setGender(gender); }
	func setAnswer(questionID: Int, answer: Int) { Questionnaire.setAnswer(questionID, answer: answer); }
	func getAnswer(questionID: Int) -> Int? { return Questionnaire.getAnswer(questionID); }
	func setAppState(appState: ApplicationState) { AppProperties.setAppState(appState); }
	func getAppState() -> ApplicationState? { return AppProperties.getAppState(); }

	func getImages(imagesURL: NSURL) -> Array<UIImage>? { return ImagesIO.getImages(imagesURL) }
	func saveImage(imagesURL: NSURL, image: UIImage) { ImagesIO.saveImage(imagesURL, image: image) }
	func removeImage(imagesURL: NSURL, index: Int) { ImagesIO.removeImage(imagesURL, index: index) }
	func getImagesCount(imagesURL: NSURL) -> Int { return ImagesIO.getImagesCount(imagesURL) }
	func getVideo(oldVideo videoURL: NSURL) -> NSURL? { return VideoIO.getVideo(oldVideo: videoURL) }
	func setVideo(oldVideo videoURL: NSURL, newVideo newVideoURL: NSURL?) { VideoIO.setVideo(oldVideo: videoURL, newVideo: newVideoURL) }
	func getAudio(oldAudio audioURL: NSURL) -> NSURL? { return AudioIO.getAudio(oldAudio: audioURL) }
	func setAudio(oldAudio audioURL: NSURL, newAudio newAudioURL: NSURL?) { AudioIO.setAudio(oldAudio: audioURL, newAudio: newAudioURL) }

	func addNewEntry(entry: Entry) { SQLiteDBManager.insertEntry(entry) }
	func getEntries() -> [Entry]? { return SQLiteDBManager.entries() }
	func getEntryForID(entry_id: Int64) -> Entry? { return SQLiteDBManager.entryForID(entry_id) }

	func purgeAllData() {
		purgeUserData();
		purgeAppData();
		purgeQuestionnaireAnswers();
		//purgeTempMedia(TEMP_DIR_URL)
		purgeDB();
	}

	func purgeUserData() { UserProperties.purgeData(); }
	func purgeAppData() { AppProperties.purgeData(); }
	func purgeQuestionnaireAnswers() { Questionnaire.purgeData(); }
	func purgeDB() {
		fatalError("Not implemented yet.");
		// SQLiteDBManager.purgeDB();
	}

	func purgeTempMedia(parentDir: NSURL) {
		fatalError("Not implemented yet.");

//		ImagesIO.purgeImages(parentDir);
//		AudioIO.purgeAudio(oldAudio: parentDir);
//		VideoIO.purgeVideo(oldVideo: parentDir);
	}
}