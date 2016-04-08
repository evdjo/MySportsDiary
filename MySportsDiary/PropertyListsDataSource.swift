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

    func tempMovieURL() -> NSURL {
        return fileURL(file: "temp_video.MOV", under: .CachesDirectory);
    }
    func putNewMovie(newMovieURL: NSURL) {
        let url = tempMovieURL();
        if fileExists(url) {
            deleteFile(file: tempMovieURL());
        }
        myCopy(newMovieURL, toPath: url);
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