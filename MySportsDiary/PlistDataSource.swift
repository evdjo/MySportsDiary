//
//  File.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 21/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation

class PlistDataSource: DataSource {
    
    
    private let UserInfo = "userinfo.plist";
    private let AGE = "AGE";
    private let GENDER = "GENDER";
    private let AnswersTemp = "answerstemp.plist"
    
    
    
    func initialQuestionnareAnswered() -> Bool {
        return getProperty(AGE) != nil && getProperty(GENDER) != nil;
    }
    
    
    
    func getProperty(key: String) ->Int? {
        let fileURL = dataFileURL(UserInfo)
        if (NSFileManager.defaultManager().fileExistsAtPath(fileURL.path!)) {
            if var dict = NSDictionary(contentsOfURL: fileURL) as? Dictionary<String,Int> {
                return dict[key];
            }
        }
        return nil;
    }
    
    ///
    /// Age
    ///
    func getAge()-> Int? {
        return getProperty(AGE);
    }
    
    
    func setAge(age:Int) {
        let fileURL = dataFileURL(UserInfo)
        if (NSFileManager.defaultManager().fileExistsAtPath(fileURL.path!)) {
            if var dict = NSDictionary(contentsOfURL: fileURL) as? Dictionary<String,Int> {
                dict[AGE] = age;
                (dict as NSDictionary).writeToURL(fileURL, atomically: true)
            }
        } else {
            ([AGE: age] as NSDictionary).writeToURL(fileURL, atomically: true);
        }
    }
    
    ///
    /// Gender
    ///
    func getGender()-> Gender? {
        if let gender = getProperty(GENDER) {
            return Gender(rawValue: gender);
        }
        return nil;
    }
    
    
    func setGender(gender:Gender) {
        let fileURL = dataFileURL(UserInfo)
        if (NSFileManager.defaultManager().fileExistsAtPath(fileURL.path!)) {
            if var dict = NSDictionary(contentsOfURL: fileURL) as? Dictionary<String,Int> {
                dict[GENDER] = gender.rawValue;
                (dict as NSDictionary).writeToURL(fileURL, atomically: true)
            }
        } else {
            ([GENDER: gender.rawValue] as NSDictionary).writeToURL(fileURL, atomically: true);
        }
    }
    
    
    
    ///
    /// Questionnaire answers
    ///
    
    func saveAnswer(questionID: Int, answer: Int) {
        let fileURL = dataFileURL(AnswersTemp)
        if (NSFileManager.defaultManager().fileExistsAtPath(fileURL.path!)) {
            if var dict = NSDictionary(contentsOfURL: fileURL) as? Dictionary<String,Int> {
                dict.updateValue(answer, forKey: String(questionID));
                (dict as NSDictionary).writeToURL(fileURL,atomically: true);
            }
        } else {
            ([String(questionID) : answer] as NSDictionary).writeToURL(fileURL, atomically: true);
        }
        
    }
    
    func getAnswer(questionID: Int) -> Int? {
        let fileURL = dataFileURL(AnswersTemp)
        if (NSFileManager.defaultManager().fileExistsAtPath(fileURL.path!)) {
            if var dict = NSDictionary(contentsOfURL: fileURL) as? Dictionary<String,Int> {
                return dict[String(questionID)];
            }
        }
        return nil;
    }
    
}
