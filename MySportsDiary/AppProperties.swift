//
//  File.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 31/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation

class AppProperties {
	///
	/// GET
	///
	static func getAppState() -> ApplicationState? {
		if let dict = NSDictionary(contentsOfURL: DataConfig.APP_PROP_URL)
		as? Dictionary<String, String> {
			if let appState = dict[DataConfig.APP_STATE_KEY] {
				return ApplicationState(rawValue: appState);
			}
		}
		return nil; // was never set before
	}
	///
	/// SET
	///
	static func setAppState(state: ApplicationState) {
		if var dict = NSDictionary(contentsOfURL: DataConfig.APP_PROP_URL)
		as? Dictionary<String, String> {
			dict.updateValue(state.rawValue, forKey: DataConfig.APP_STATE_KEY);
			(dict as NSDictionary).writeToURL(DataConfig.APP_PROP_URL, atomically: true);
		} else {
			let dict = ([DataConfig.APP_STATE_KEY: state.rawValue] as NSDictionary);
			dict.writeToURL(DataConfig.APP_PROP_URL, atomically: true); // first time setting
		}
	}

	///
	/// GET
	///
	static func getDiaryStart() -> String? {
		if let dict = NSDictionary(contentsOfURL: DataConfig.APP_PROP_URL)
		as? Dictionary<String, String> {
			if let dateString = dict[DataConfig.APP_DIARY_START] {
				return dateString;
			}
		}
		return nil; // was never set before
	}

	static func setDiaryStart(dateString: String) {
		if var dict = NSDictionary(contentsOfURL: DataConfig.APP_PROP_URL)
		as? Dictionary<String, String> {
			dict.updateValue(dateString, forKey: DataConfig.APP_DIARY_START);
			(dict as NSDictionary).writeToURL(DataConfig.APP_PROP_URL, atomically: true);
		} else {
			let dict = ([DataConfig.APP_DIARY_START: dateString] as NSDictionary);
			dict.writeToURL(DataConfig.APP_PROP_URL, atomically: true); // first time setting
		}
	}

	///
	/// PURGE
	///
	static func purgeData() {
		deleteFile(file: DataConfig.APP_PROP_URL);
	}
}