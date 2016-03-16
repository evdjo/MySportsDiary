//
//  SQLiteDataManagerDelegate.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 13/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation

class SQLiteDataManagerDelegate : DataManagerDelegate {
    
    func getAge()-> Int? {
        if let age = loadFromDB(
            dbName: SQLiteDataManagerDelegate.USERAGE,
            dbCreate: SQLiteDataManagerDelegate.CREATE_USERAGE,
            dbGet: SQLiteDataManagerDelegate.GET_USERAGE) {
                return age;
        } else {
            return nil;
        }
    }
    
    func setAge(age:Int) {
        saveToDB(age,
            dbName: SQLiteDataManagerDelegate.USERAGE,
            dbCreate: SQLiteDataManagerDelegate.CREATE_USERAGE,
            dbUpdate: SQLiteDataManagerDelegate.UPDATE_USERAGE);
        print("age saved successfully");
    }
    
    
    func getGender()-> Gender? {
        if let gender = loadFromDB(
            dbName: SQLiteDataManagerDelegate.USERGENDER,
            dbCreate: SQLiteDataManagerDelegate.CREATE_USERGENDER,
            dbGet: SQLiteDataManagerDelegate.GET_USERGENDER) {
                return Gender(rawValue: gender);
        }
        return nil;
    }
    
    func setGender(gender:Gender) {
        saveToDB(gender.rawValue,
            dbName: SQLiteDataManagerDelegate.USERGENDER,
            dbCreate: SQLiteDataManagerDelegate.CREATE_USERGENDER,
            dbUpdate: SQLiteDataManagerDelegate.UPDATE_USERGENDER);
        print("gender saved successfully");
    }
    
    
    
    
    
    
    
    
    
    private static let USERAGE = "USERAGE";
    private static let CREATE_USERAGE = "CREATE TABLE IF NOT EXISTS \(USERAGE) (KEY INTEGER PRIMARY KEY, AGE INTEGER);";
    private static let UPDATE_USERAGE = "INSERT OR REPLACE INTO \(USERAGE) VALUES(?, ?);";
    private static let GET_USERAGE = "SELECT KEY, AGE FROM \(USERAGE)";
    
    private static let USERGENDER = "USERGENDER";
    private static let CREATE_USERGENDER = "CREATE TABLE IF NOT EXISTS \(USERGENDER) (KEY INTEGER PRIMARY KEY, GENDER INTEGER);";
    private static let UPDATE_USERGENDER = "INSERT OR REPLACE INTO \(USERGENDER) VALUES(?, ?);";
    private static let GET_USERGENDER = "SELECT KEY, GENDER FROM \(USERGENDER)";
    
    
    private func saveToDB(value:Int, dbName: String, dbCreate: String, dbUpdate:String) {
        // Open the db
        var database:COpaquePointer = nil;
        var result = sqlite3_open(dataBaseFile(dbName), &database);
        if(result != SQLITE_OK){print("opening user db has failed"); sqlite3_close(database); return;}
        // Create the table
        var errMsg:UnsafeMutablePointer<Int8> = nil;
        result = sqlite3_exec(database, dbCreate, nil, nil, &errMsg);
        if(result != SQLITE_OK){print("creating user table has failed"); sqlite3_close(database); return;}
        
        // Insert the value
        var statement:COpaquePointer = nil;
        if(sqlite3_prepare_v2(database,dbUpdate, -1, &statement, nil) == SQLITE_OK) {
            sqlite3_bind_int(statement,1, Int32(1)); sqlite3_bind_int(statement,2, Int32(value));
        }
        if(sqlite3_step(statement) != SQLITE_DONE) {print("Error updating table"); sqlite3_close(database); return;}
        sqlite3_finalize(statement); sqlite3_close(database);
    }
    
    
    private func loadFromDB(dbName dbName: String, dbCreate: String, dbGet:String) -> Int? {
        // Open the db
        var database:COpaquePointer = nil;
        var result = sqlite3_open(dataBaseFile(dbName), &database);
        if(result != SQLITE_OK){print("opening user DB has failed"); sqlite3_close(database); return nil;}
        // Create the table
        var errMsg:UnsafeMutablePointer<Int8> = nil;
        result = sqlite3_exec(database, dbCreate, nil, nil, &errMsg);
        if(result != SQLITE_OK){print("creating table has failed"); sqlite3_close(database); return nil;}
        // Fetch the value
        var value: Int? = nil;
        var statement:COpaquePointer = nil;
        if(sqlite3_prepare_v2(database, dbGet, -1, &statement,nil) == SQLITE_OK) {
            if(sqlite3_step(statement) == SQLITE_ROW) {
                value = Int(sqlite3_column_int(statement,1));
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(database);
        return value;
    }
    
    
    private func dataBaseFile(whichDB: String) -> String {
        let urls = NSFileManager.defaultManager().URLsForDirectory(
            .DocumentDirectory, inDomains: .UserDomainMask);
        return urls.first!.URLByAppendingPathComponent(whichDB).path!;
    }
    
    
}