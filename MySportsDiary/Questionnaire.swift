//
//  QuestionnaireAnswers.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 31/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation

class Questionnaire {

	///
	/// Questionnaire temp answers
	///
	static func setAnswer(questionID: Int, answer: Int) {
		if var dict = NSDictionary(contentsOfURL: DataConfig.ANSWERS_URL) as? Dictionary<String, Int> {
			dict.updateValue(answer, forKey: String(questionID));
			(dict as NSDictionary).writeToURL(DataConfig.ANSWERS_URL, atomically: true);
		} else {
			([String(questionID): answer] as NSDictionary).writeToURL(DataConfig.ANSWERS_URL, atomically: true);
		}
	}

	static func getAnswer(questionID: Int) -> Int? {
		if var dict = NSDictionary(contentsOfURL: DataConfig.ANSWERS_URL) as? Dictionary<String, Int> {
			return dict[String(questionID)];
		} else {
			return nil;
		}
	}

	///
	/// PURGE
	///
	static func purgeData() {
		deleteFile(file: DataConfig.ANSWERS_URL)
	}
}