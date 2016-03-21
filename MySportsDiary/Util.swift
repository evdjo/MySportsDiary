//
//  Util.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 21/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation


enum Gender : Int {
    case BOY = 1
    case GIRL = 2
}

enum QuestionnaireType {
    
    case INITIAL
    case FINAL
    case NORMAL
    
}

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