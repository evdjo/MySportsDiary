//
//  QuestionnaireAnswers.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 31/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation


class QuestionnaireAnswers {
    
    
    static private let AnswersTempFile = "answerstemp.plist";
    static private let TempImageNames = "tempImageNames.plist";
    static private let AnswersTempFileURL = fileURL(file: AnswersTempFile, under: .LibraryDirectory);
    
    ///
    /// Questionnaire temp answers
    ///
    static func setAnswer(questionID: Int, answer: Int) {
        if var dict = NSDictionary(contentsOfURL: AnswersTempFileURL) as? Dictionary<String,Int> {
            dict.updateValue(answer, forKey: String(questionID));
            (dict as NSDictionary).writeToURL(AnswersTempFileURL,atomically: true);
        } else {
            ([String(questionID) : answer] as NSDictionary).writeToURL(AnswersTempFileURL, atomically: true);
        }
        
    }
    
    static func getAnswer(questionID: Int) -> Int? {
        if var dict = NSDictionary(contentsOfURL: AnswersTempFileURL) as? Dictionary<String,Int> {
            return dict[String(questionID)];
        } else {
            return nil;
        }
    }
    
    ///
    /// PURGE
    ///
    static func purgeData() {
    deleteFile(file: AnswersTempFileURL)
    }
    
}