//
//  File.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 21/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation
import UIKit

class PlistDataSource: DataSource {
    
    internal let UserInfoFile = "userinfo.plist";
    internal let AGE = "AGE";
    internal let GENDER = "GENDER";
    
    private let APPSTATE = "APPSTATE";
    private let AppPropertiesFile = "appstate.plist";
    
    private let AnswersTempFile = "answerstemp.plist";
    
    private let TempImageURLs = "tempImageURLs.plist";
    
    
    
    
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
    
    ///
    /// Delete a file
    ///
    
    private func deleteFile(fileName: String) -> Bool{
        let filePath = dataFilePath(fileName)
        if (NSFileManager.defaultManager().fileExistsAtPath(filePath)) {
            do {
                try NSFileManager.defaultManager().removeItemAtPath(filePath);
                return true;
            } catch {
                return false;
            }
        }
        return false;
    }
    
    
    
    
    ///
    /// Save image to a temp folder
    ///
    func saveTempImage(image: UIImage) {
        let imageFileName = "MySportsDiaryTempImage_\(timestamp()).png"
        let path = tempMediaFolderURL()
        let imagePath = path.URLByAppendingPathComponent(imageFileName);
        UIImagePNGRepresentation(image)?.writeToURL(imagePath, atomically: true);
        saveTempImageName(imageFileName);
    }
    
    func getTempImages() -> [UIImage?] {
        let imageURLs: [NSURL] = getImageURLs();
        var images: [UIImage?] = Array<UIImage>();
        for url in imageURLs {
            print(NSFileManager.defaultManager().fileExistsAtPath(url.path!))
            if let image = UIImage(contentsOfFile: url.path!) {
                images.append(image);
            }
        }
        
        return images;
    }
    
    ///
    /// List of all temp images currently cached to files
    ///
    private func getImageURLs() -> [NSURL] {
        let fileURL = dataFileURL(TempImageURLs)
        if (NSFileManager.defaultManager().fileExistsAtPath(fileURL.path!)) {
            if let dict = NSArray(contentsOfURL: fileURL) as? Array<String> {
                var returnURLs = Array<NSURL>();
                let folderURL = tempMediaFolderURL();
                for name in dict {
                    returnURLs.append(folderURL.URLByAppendingPathComponent(name));
                }
                return returnURLs;
            }
        }
        return [];
    }
    
    private func saveTempImageName(name: String) {
        let fileURL = dataFileURL(TempImageURLs)
        if (NSFileManager.defaultManager().fileExistsAtPath(fileURL.path!)) {
            if var dict = NSArray(contentsOfURL: fileURL) as? Array<String> {
                dict.append(name);
                (dict as NSArray).writeToURL(fileURL,atomically: true);
            }
        } else {
            ([name as NSString] as NSArray).writeToURL(fileURL, atomically: true);
        }
        
    }
    
    
    
    
    func deleteAllFiles() {
        deleteFile(UserInfoFile);
        deleteFile(AnswersTempFile);
        deleteFile(AppPropertiesFile);
    }
    
}
