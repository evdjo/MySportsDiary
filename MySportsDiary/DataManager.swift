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
    
    private static func getManagerDelegate() -> SQLiteDataManagerDelegate {
        return SQLiteDataManagerDelegate();
    }
    
    
    
    
    
    
    
    private var dataSource: SQLiteDataManagerDelegate;
    
    private init(_dataSource: SQLiteDataManagerDelegate) {
        dataSource = _dataSource;
    }
    
    func saveGender(gender: Gender) {
        dataSource.setGender(gender);
    }
    
    func saveAge(age: Int) {
        dataSource.setAge(age);
    }
    
    func getGender() -> Gender? {
        return dataSource.getGender();
    }
    
    func getAge() -> Int?{
        return dataSource.getAge();
    }
    
}