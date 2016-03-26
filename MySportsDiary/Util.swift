//
//  Util.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 21/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation


///
/// Gender 
///
enum Gender : Int {
    case BOY = 1
    case GIRL = 2
}



///
/// Initial means we need to ask initial questionnaire & age/gender
/// Diary means the user is currently able to record new events
/// Final means the user must answer the final questionnaire and send the data
///
enum ApplicationState : String {
    case Initial = "InitialState"
    case Diary = "DiaryState"
    case Final = "FinalState"
}

///
/// File path/url functions
///
internal func dataFilePath(whichFile: String) -> String {
    let urls = NSFileManager.defaultManager().URLsForDirectory(
        .DocumentDirectory, inDomains: .UserDomainMask);
    return urls.first!.URLByAppendingPathComponent(whichFile).path!;
}

internal func dataFileURL(whichFile: String) -> NSURL {
    let urls = NSFileManager.defaultManager().URLsForDirectory(
        .DocumentDirectory, inDomains: .UserDomainMask)
    return urls.first!.URLByAppendingPathComponent(whichFile)
}