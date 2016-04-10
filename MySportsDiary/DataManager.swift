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

protocol DataManager {

	func getAge() -> Int?;
	func getGender() -> Gender?;
	func setAge(age: Int);
	func setGender(gender: Gender);

	func setAnswer(questionID: Int, answer: Int);
	func getAnswer(questionID: Int) -> Int?;

	func getAppState() -> ApplicationState?;
	func setAppState(appState: ApplicationState);

	func setTempImages(images: [UIImage]);
	func getTempImages() -> [UIImage]?;
	func getImagesCount() -> Int;
	func saveTempImage(image: UIImage);
	func removeTempImage(index: Int);

	func getTempVideo() -> NSURL?;
	func setTempVideo(videoURL: NSURL?);

	func getTempAudio() -> (url: NSURL, exists: Bool);
	func setTempAudio(audioURL: NSURL?);

    func addNewEntry(skill: String, description: String);
    
	/// CAUTION --- deletes ALL app generated data!
	func purgeAllData();

	/// CAUTION --- deletes AGE AND GENDER ! Used for testing purposes.
	func purgeUserData();

	/// CAUTION --- deletes APP PROPERTIES ! Used for testing purposes.
	func purgeAppData();

	/// CAUTION --- deletes the QUESTIONNAIRE ANSWERS ! Used for testing purposes.
	func purgeQuestionnaireAnswers();

	/// CAUTION --- deletes the PHOTOS/VIDEO/AUDIO TEMP FILES !
	func purgeTempMedia();
}

private var instance: DataManager? = nil;

internal func DataManagerInstance() -> DataManager {
	if instance == nil {
		instance = MainDataManager();
	}
	return instance!;
}
