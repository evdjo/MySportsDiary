//
//  File.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 31/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation


///
/// Application state
///

class AppProperties {
    static private let AppStateKey = "AppState";
    static private let AppPropertiesFile = "appproperties.plist";
    static private var AppPropsURL: NSURL = fileURL(file: AppPropertiesFile, under: .LibraryDirectory)
    
    ///
    /// GET
    ///
    static func getAppState() -> ApplicationState? {
        if let dict = NSDictionary(contentsOfURL: AppPropsURL) as? Dictionary<String,String> {
            if let appState = dict[AppStateKey] {
                return ApplicationState(rawValue: appState);
            }
        }
        return nil; // was never set before
    }
    ///
    /// SET
    ///
    static func setAppState(state: ApplicationState){
        if var dict = NSDictionary(contentsOfURL: AppPropsURL) as? Dictionary<String,String> {
            dict.updateValue(state.rawValue, forKey: AppStateKey);
            (dict as NSDictionary).writeToURL(AppPropsURL, atomically: true);
            
        } else {
            let dict = ([AppStateKey : state.rawValue] as NSDictionary);
            dict.writeToURL(AppPropsURL, atomically: true); // first time setting
            
        }
    }
    
    
    ///
    /// PURGE
    ///
    static func purgeData() {
        deleteFile(file: AppPropsURL);
    }
    
}