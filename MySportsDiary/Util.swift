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
enum Gender: Int {
    case BOY = 1
    case GIRL = 2
}

///
/// Initial means we need to ask initial questionnaire & age/gender
/// Diary means the user is currently able to record new events
/// Final means the user must answer the final questionnaire and send the data
///
enum ApplicationState: String {
    case Initial = "InitialState"
    case Diary = "DiaryState"
    case Final = "FinalState"
}

///
/// Timestamp since epoch
///

internal func timestamp() -> String {
    return "\(NSDate().timeIntervalSince1970 * 1000)";
}