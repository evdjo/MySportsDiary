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

///
/// Get the default NSFileManager
///
internal var fileManager: NSFileManager {
    return NSFileManager.defaultManager();
}

///
/// Get a NSURL with file name "file", contained under the "under" NSsearchDirectory
///
/// Example usage:
///
/// fileURL("myFile.txt", NSSearchPathDirectory.LibraryDirectory)
///
///
/// - parameters:
///   - file: the file name e.g. myFile.txt
///   - under: the directory to create under e.g. NSSearchPathDirectory.LibraryDirectory
/// - returns: a NSURL to the file
internal func fileURL(file file: String, under: NSSearchPathDirectory) -> NSURL {
    return dirURL(under).URLByAppendingPathComponent(file)
}

///
/// Get a NSURL to a directory the "under" NSsearchDirectory. The NSFileManager is used,
/// and the returned directory is under the User Domain Mask.
///
/// Example usage:
///
/// dirURL(NSSearchPathDirectory.LibraryDirectory)
///
///
/// - parameters:
///   - under: the search path, e.g. NSSearchPathDirectory.LibraryDirectory
/// - returns: a NSURL to the directory
internal func dirURL(under: NSSearchPathDirectory) -> NSURL {
    return fileManager.URLsForDirectory(under, inDomains: .UserDomainMask)[0]
}

///
/// Get a NSURL to a sub directory the "under" NSsearchDirectory. The NSFileManager is used,
/// and the returned directory is under the User Domain Mask.
///
/// Example usage:
///
/// createSubDir("mySubDir", under: NSSearchPathDirectory.LibraryDirectory)
///
///
/// - parameters:
///   - dir: the name of the sub directory
///   - under: the search path, e.g. NSSearchPathDirectory.LibraryDirectory
/// - returns: a NSURL to the directory
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
///
/// Delete the file at the specified NSURL
/// - parameters
///  - file the file to delete
/// - returns true if the deletion succeeeded
///
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