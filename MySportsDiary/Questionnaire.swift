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
	/// Set questionnaire answer
	///
	static func setAnswer(questionID: Int, answer: Int, forState: ApplicationState) {
		let url = forState == .Initial ?
		DataConfig.ANSWERS_URL_I : DataConfig.ANSWERS_URL_F
		
		if var dict = NSDictionary(contentsOfURL: url)
		as? Dictionary<String, Int> {
			dict.updateValue(answer, forKey: String(questionID));
			(dict as NSDictionary).writeToURL(url, atomically: true);
		} else {
			([String(questionID): answer] as NSDictionary)
				.writeToURL(url, atomically: true);
		}
	}
	
	///
	/// Get questionnaire answer
	///
	static func getAnswer(questionID: Int, forState: ApplicationState) -> Int? {
		let url = forState == .Initial ?
		DataConfig.ANSWERS_URL_I : DataConfig.ANSWERS_URL_F
		
		if var dict = NSDictionary(contentsOfURL: url)
		as? Dictionary<String, Int> {
			return dict[String(questionID)];
		} else {
			return nil;
		}
	}
	
	///
	/// Delete answers
	///
	static func purgeData() {
		deleteFile(file: DataConfig.ANSWERS_URL_I)
		deleteFile(file: DataConfig.ANSWERS_URL_F)
	}
}