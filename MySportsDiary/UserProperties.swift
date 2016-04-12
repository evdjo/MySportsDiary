//
//  UserProperties.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 31/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation

class UserProperties {

	///
	/// GET
	///
	static func getAge() -> Int? {
		return getUserProperty(USER_AGE_KEY);
	}

	static func getGender() -> Gender? {
		if let gender = getUserProperty(USER_GENDER_KEY) {
			return Gender(rawValue: gender);
		}
		return nil;
	}

	static private func getUserProperty(key: String) -> Int? {
		if var dict = NSDictionary(contentsOfURL: USER_PROP_URL)
		as? Dictionary<String, Int> {
			return dict[key];
		}
		return nil;
	}

	///
	/// SET
	///
	static func setAge(age: Int) {
		if var dict = NSDictionary(contentsOfURL: USER_PROP_URL)
		as? Dictionary<String, Int> {
			dict[USER_AGE_KEY] = age;
			(dict as NSDictionary).writeToURL(USER_PROP_URL, atomically: true)
		} else {
			([USER_AGE_KEY: age] as NSDictionary).writeToURL(USER_PROP_URL, atomically: true);
		}
	}

	static func setGender(gender: Gender) {
		if var dict = NSDictionary(contentsOfURL: USER_PROP_URL)
		as? Dictionary<String, Int> {
			dict[USER_GENDER_KEY] = gender.rawValue;
			(dict as NSDictionary).writeToURL(USER_PROP_URL, atomically: true)
		} else {
			([USER_GENDER_KEY: gender.rawValue] as NSDictionary).writeToURL(USER_PROP_URL, atomically: true);
		}
	}

	///
	/// PURGE
	///
	static func purgeData() {
		deleteFile(file: USER_PROP_URL);
	}
}