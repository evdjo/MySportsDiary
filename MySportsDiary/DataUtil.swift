//
//  DataUtil.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 31/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation

///
/// File path/url functions
///

var fileManager: NSFileManager {
    return NSFileManager.defaultManager();
}

internal func fileURL(file file: String, under: NSSearchPathDirectory) -> NSURL {
    return dirURL(under).URLByAppendingPathComponent(file)
}

internal func dirURL(directory: NSSearchPathDirectory) -> NSURL {
    let urls = fileManager.URLsForDirectory(directory, inDomains: .UserDomainMask)
    return urls[0];
}

internal func createSubDir(dir subDirName: String, under: NSSearchPathDirectory) -> NSURL {
    let subDir = dirURL(under).URLByAppendingPathComponent(subDirName);
    do {
        try fileManager.createDirectoryAtURL(subDir, withIntermediateDirectories: true, attributes: nil);
    }
    catch {
        fatalError("Could not create dir at the specified location");
    }
    return subDir;
}

internal func deleteFile(file fileToDeleteURL: NSURL) -> Bool {
    if let filePath = fileToDeleteURL.path {
        if (NSFileManager.defaultManager().fileExistsAtPath(filePath)) {
            do {
                try NSFileManager.defaultManager().removeItemAtPath(filePath);
                return true;
            } catch {
                return false;
            }
        }
    }
    return false;
}