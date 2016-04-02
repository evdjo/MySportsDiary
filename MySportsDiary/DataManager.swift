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
class DataManager {

    ///
    /// Singleton
    ///
    private static var instance: DataSource?;

    internal static func getManagerInstance() -> DataSource {
        if instance == nil { instance = constructInstance(); }
        return instance!;
    }

    private static func constructInstance() -> DataSource {
        return PropertyListDataSource();
    }
}
protocol DataSource {

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

    func saveTempImage(image: UIImage);
    func removeTempImage(index: Int);

    /// CAUTION --- deletes everything ! Used for testing purposes
    func purgeData();
}

