//
//  PropertyListsDataSource.swift
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

    func setAnswer(questionID: Int, answer: Int) { QuestionnaireAnswers.setAnswer(questionID, answer: answer); }
    func getAnswer(questionID: Int) -> Int? { return QuestionnaireAnswers.getAnswer(questionID); }

    func setAppState(appState: ApplicationState) { AppProperties.setAppState(appState); }
    func getAppState() -> ApplicationState? { return AppProperties.getAppState(); }

    func getTempImages() -> Array<UIImage>? { return TemporaryImages.getTempImages(); }
    func saveTempImage(image: UIImage) { TemporaryImages.saveTempImage(image); }
    func removeTempImage(index: Int) { TemporaryImages.removeTempImage(index); }
    func getImagesCount() -> Int { return TemporaryImages.getImagesCount(); }
    func moveTempImages(toDir dir: String) -> NSURL { return TemporaryImages.moveTempImages(toDir: dir) }

    func getTempVideo() -> NSURL? { return TemporaryVideo.getTempVideo(); }
    func setTempVideo(videoURL: NSURL?) { TemporaryVideo.setTempVideo(videoURL); }

    func getTempAudio() -> (url: NSURL, exists: Bool) { return TemporaryAudio.getTempAudio(); }
    func setTempAudio(audioURL: NSURL?) { TemporaryAudio.setTempAudio(audioURL); }

    func addNewEntry(entry: Entry) {
        insertEntry(entry)
    }

    func getEntries() -> [Entry]? {
        return entries();
    }

    func getEntryForID(entry_id: Int64) -> Entry? {
        return entryForID(entry_id);
    }

    func purgeEntriesDB() {
        deleteFile(file: DB_FILE_URL);
    }

    ///
    /// CAUTION!  Does what you think! (Deletes everything)
    /// Used for testing purposes.
    ///
    func purgeAllData() {
        UserProperties.purgeData();
        AppProperties.purgeData();
        QuestionnaireAnswers.purgeData();
        self.purgeTempMedia()
        self.purgeEntriesDB();
    }

    func purgeUserData() {
        UserProperties.purgeData();
    }
    func purgeAppData() {
        AppProperties.purgeData();
    }
    func purgeQuestionnaireAnswers() {
        QuestionnaireAnswers.purgeData();
    }
    func purgeTempMedia() {
        TemporaryImages.purgeImages();
        TemporaryAudio.purgeTempAudio();
        TemporaryVideo.purgeTempVideo();
    }
}