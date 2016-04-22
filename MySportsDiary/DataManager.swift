//
//  DataManager.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 13/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation
import UIKit

protocol DataManager {
	func getAge() -> Int?;
	func getGender() -> Gender?;
	func setAge(age: Int);
	func setGender(gender: Gender);

	func setAnswer(questionID: Int, answer: Int);
	func getAnswer(questionID: Int) -> Int?;

	func getAppState() -> ApplicationState?;
	func setAppState(appState: ApplicationState);
	func setDiaryStart(dateString: String);
	func getDiaryStart() -> String?;

	func getImages(imagesURL: NSURL) -> [UIImage]?;
	func getImagesCount(imagesURL: NSURL) -> Int;
	func saveImage(imagesURL: NSURL, image: UIImage);
	func removeImage(imagesURL: NSURL, index: Int);

	func getVideo(oldVideo oldVideo: NSURL) -> NSURL?;
	func setVideo(oldVideo oldVideo: NSURL, newVideo: NSURL?);

	func getAudio(oldAudio oldAudio: NSURL) -> NSURL?;
	func setAudio(oldAudio oldAudio: NSURL, newAudio: NSURL?);

	func addNewEntry(entry: Entry);

	func getEntries() -> [Entry]?
	func getEntriesByDate() -> EntriesByDate;

	func getEntryForID(entry_id: Int64) -> Entry?;
	func updateEntryWithID(id id: Int64, newDescr: String);

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
	/// CAUTION --- deletes the ENTRIES DATABASE FILE & THE ENTRIES DATA!
	func purgeEntries();
}
