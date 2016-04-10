//
//  PropertyListsDataSource.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 31/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation
import UIKit

class PropertyListDataSource: DataSource {

	func getAge() -> Int? { return UserProperties.getAge(); }
	func getGender() -> Gender? { return UserProperties.getGender(); }

	func setAge(age: Int) { UserProperties.setAge(age); }
	func setGender(gender: Gender) { UserProperties.setGender(gender); }

	func setAnswer(questionID: Int, answer: Int) { QuestionnaireAnswers.setAnswer(questionID, answer: answer); }
	func getAnswer(questionID: Int) -> Int? { return QuestionnaireAnswers.getAnswer(questionID); }

	func setAppState(appState: ApplicationState) { AppProperties.setAppState(appState); }
	func getAppState() -> ApplicationState? { return AppProperties.getAppState(); }

	func setTempImages(images: Array<UIImage>) { return TemporaryImages.setTempImages(images); }
	func getTempImages() -> Array<UIImage>? { return TemporaryImages.getTempImages(); }
	func saveTempImage(image: UIImage) { TemporaryImages.saveTempImage(image); }
	func removeTempImage(index: Int) { TemporaryImages.removeTempImage(index); }
	func getImagesCount() -> Int { return TemporaryImages.getImagesCount(); }

	private func tempVideoURL() -> NSURL {
		return fileURL(file: "temp_video.MOV", under: .CachesDirectory);
	}

	private func tempAudioURL() -> NSURL {
		return fileURL(file: "audio.caf", under: .CachesDirectory);
	}

	func getTempAudio() -> (url: NSURL, exists: Bool) {
		let audio = tempAudioURL();
		return (audio, fileExists(audio))
	}

	func setTempAudio(newAudio: NSURL?) {
		let audioFile = getTempAudio();
		if audioFile.exists {
			deleteFile(file: audioFile.url);
		}
		if let newAudio = newAudio {
			myCopy(newAudio, toPath: audioFile.url);
		}
	}

///
/// gets the temporary video, if it was not set before, will return nil
///
	func getTempVideo() -> NSURL? {
		let video = tempVideoURL();
		if fileExists(video) {
			return video;
		}
		return nil;
	}
///
/// replaces the old video with new one
/// if videoURL is nil, will delete the video at tempFileURL()
///
	func setTempVideo(videoURL: NSURL?) {
		let url = tempVideoURL();
		if fileExists(url) {
			deleteFile(file: tempVideoURL());
		}
		if let videoURL = videoURL {
			myCopy(videoURL, toPath: url);
		}
	}

	/// CAUTION --- deletes everything ! Used for testing purposes.
	func purgeData() {
		UserProperties.purgeData();
		AppProperties.purgeData();
		QuestionnaireAnswers.purgeData();
	}

	func purgeTempMedia() {
		TemporaryImages.purgeData();
	}
}