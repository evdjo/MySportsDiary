//
//  File.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 21/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation

class PlistDataSource: DataSource {
    
    private let UserInfoFile = "userinfo.plist";
    private let AGE = "AGE";
    private let GENDER = "GENDER";
    
    private let APPSTATE = "APPSTATE";
    private let AppPropertiesFile = "appstate.plist";
    
    private let AnswersTempFile = "answerstemp.plist";
    
    
    
    
    ///
    /// Application state
    ///
    func getAppState() -> ApplicationState? {
        let fileURL = dataFileURL(AppPropertiesFile)
        if (NSFileManager.defaultManager().fileExistsAtPath(fileURL.path!)) {
            if let dict = NSDictionary(contentsOfURL: fileURL) as? Dictionary<String,String> {
                if let appState = dict[APPSTATE] {
                    return ApplicationState(rawValue: appState)
                }
            }
        }
        return nil;
    }
    
    func setAppState(appState: ApplicationState){
        let fileURL = dataFileURL(AppPropertiesFile)
        if (NSFileManager.defaultManager().fileExistsAtPath(fileURL.path!)) {
            if var dict = NSDictionary(contentsOfURL: fileURL) as? Dictionary<String,String> {
                dict.updateValue(appState.rawValue, forKey: APPSTATE);
                (dict as NSDictionary).writeToURL(fileURL,atomically: true);
            }
        } else {
            ([APPSTATE : appState.rawValue] as NSDictionary).writeToURL(fileURL, atomically: true);
        }
        
        
    }
    func saveCurrentAnswersInitial(){
        
    }
    
    
    
    ///
    /// Age and Gender
    ///
    func getAge()-> Int? {
        return getUserProperty(AGE);
    }
    
    func getGender()-> Gender? {
        if let gender = getUserProperty(GENDER) {
            return Gender(rawValue: gender);
        }
        return nil;
    }
    
    private func getUserProperty(key: String) ->Int? {
        let fileURL = dataFileURL(UserInfoFile)
        if (NSFileManager.defaultManager().fileExistsAtPath(fileURL.path!)) {
            if var dict = NSDictionary(contentsOfURL: fileURL) as? Dictionary<String,Int> {
                return dict[key];
            }
        }
        return nil;
    }
    
    func setAge(age:Int) {
        let fileURL = dataFileURL(UserInfoFile)
        if (NSFileManager.defaultManager().fileExistsAtPath(fileURL.path!)) {
            if var dict = NSDictionary(contentsOfURL: fileURL) as? Dictionary<String,Int> {
                dict[AGE] = age;
                (dict as NSDictionary).writeToURL(fileURL, atomically: true)
            }
        } else {
            ([AGE: age] as NSDictionary).writeToURL(fileURL, atomically: true);
        }
    }
    
    
    
    func setGender(gender:Gender) {
        let fileURL = dataFileURL(UserInfoFile)
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
    /// Questionnaire temp answers
    ///
    
    func saveAnswer(questionID: Int, answer: Int) {
        let fileURL = dataFileURL(AnswersTempFile)
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
        let fileURL = dataFileURL(AnswersTempFile)
        if (NSFileManager.defaultManager().fileExistsAtPath(fileURL.path!)) {
            if var dict = NSDictionary(contentsOfURL: fileURL) as? Dictionary<String,Int> {
                return dict[String(questionID)];
            }
        }
        return nil;
    }
}
