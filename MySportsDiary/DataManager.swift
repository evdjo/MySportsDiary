//
//  File.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 13/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation


class DataManager {
    
    
    
    
    static var instance: DataManager?;
    
    static func getManagerInstance() -> DataManager {
        if instance == nil {
            instance = DataManager(_dataSource: getManagerDelegate());
        }
        return instance!;
    }
    
    private static func getManagerDelegate() -> DataManagerDelegate {
        return PropertyListDataManagerDelegate();
    }
    
    
    
    
    
    
    
    private var dataSource: DataManagerDelegate;
    
    private init(_dataSource: DataManagerDelegate) {
        dataSource = _dataSource;
    }
    
    func saveGender(gender: Gender) {
        dataSource.setGender(gender);
        print("gender saved successfully");

    }
    
    func saveAge(age: Int) {
        dataSource.setAge(age);
        print("age saved successfully");

    }
    
    func getGender() -> Gender? {
        return dataSource.getGender();
    }
    
    func getAge() -> Int?{
        return dataSource.getAge();
    }
    
    func saveAnswer(questionID: Int, answer: Int) {
        dataSource.saveAnswer(questionID,answer: answer);
    }
    
    func getAnswer(questionID: Int) -> Int? {
        return dataSource.getAnswer(questionID);
    }
    
    
}