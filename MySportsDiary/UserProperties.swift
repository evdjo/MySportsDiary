//
//  UserProperties.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 31/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation

class UserProperties {
    private static let UserPropertiesFile = "userinfo.plist";
    private static let UserPropertiesFileURL = fileURL(file: UserPropertiesFile, under: .LibraryDirectory);
    private static let AgeKey = "AGE";
    private static let GenderKey = "GENDER";

    ///
    /// GET
    ///
    static func getAge() -> Int? {
        return getUserProperty(AgeKey);
    }

    static func getGender() -> Gender? {
        if let gender = getUserProperty(GenderKey) {
            return Gender(rawValue: gender);
        }
        return nil;
    }

    static private func getUserProperty(key: String) -> Int? {
        if var dict = NSDictionary(contentsOfURL: UserPropertiesFileURL) as? Dictionary<String, Int> {
            return dict[key];
        }
        return nil;
    }

    ///
    /// SET
    ///
    static func setAge(age: Int) {
        if var dict = NSDictionary(contentsOfURL: UserPropertiesFileURL) as? Dictionary<String, Int> {
            dict[AgeKey] = age;
            (dict as NSDictionary).writeToURL(UserPropertiesFileURL, atomically: true)
        } else {
            ([AgeKey: age] as NSDictionary).writeToURL(UserPropertiesFileURL, atomically: true);
        }
    }

    static func setGender(gender: Gender) {
        if var dict = NSDictionary(contentsOfURL: UserPropertiesFileURL) as? Dictionary<String, Int> {
            dict[GenderKey] = gender.rawValue;
            (dict as NSDictionary).writeToURL(UserPropertiesFileURL, atomically: true)
        } else {
            ([GenderKey: gender.rawValue] as NSDictionary).writeToURL(UserPropertiesFileURL, atomically: true);
        }
    }

    ///
    /// PURGE
    ///
    static func purgeData() {
        deleteFile(file: UserPropertiesFileURL);
    }
}