//
//  File.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 13/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation


//
// Handles all persistent data, such as user Age, Gender, Questionnaire Answers, Events
//
class DataManager {
    
    
    //
    // Singleton
    //
    static var instance: DataSource?;
    
    static func getManagerInstance() -> DataSource {
        if instance == nil {
            instance = constructInstance();
        }
        return instance!;
    }
    
    private static func constructInstance() -> DataSource {
        return PlistDataSource();
    }
    
    
    
}
protocol DataSource {
    func getAge()-> Int?
    func getGender()-> Gender?
    func setAge(age:Int)
    func setGender(gender:Gender)
    func saveAnswer(questionID: Int, answer: Int)
    func getAnswer(questionID: Int) -> Int?
    func initialQuestionnareAnswered() -> Bool
    
}

