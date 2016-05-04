//
//  DataUtil.swift
//  MyRugbyDiary
//
//  Created by Evdzhan Mustafa on 31/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

///
/// File path/url functions
///
import Foundation

///
/// Get the default NSFileManager
///
internal var fileManager: NSFileManager {
	return NSFileManager.defaultManager();
}

///
/// Get a top level NSURL to file/dir with name name "file".
/// The NSURL is contained under the "under" NSSearchDirectory.
///
/// - parameters:
///   - file: the file name e.g. myFile.txt or myDir
///   - under: the directory to create under e.g. .LibraryDirectory
/// - returns: a NSURL to the file
internal func fileURL(
	file file: String,
	under: NSSearchPathDirectory)
	-> NSURL
{
	return dirURL(under).URLByAppendingPathComponent(file)
}
///
/// Get a NSURL with name "file", contained under the "parent" directory.
///
/// - parameters:
///   - file: the file name e.g. myFile.txt
///   - under: the directory beneath which file is e.g. myDir
/// - returns: a NSURL to the file
internal func fileURLUnderParent(
	file file: String,
	parent: NSURL)
	-> NSURL
{
	return parent.URLByAppendingPathComponent(file)
}

///
/// Get a top level NSURL to directory under the User Domain Mask.
///
/// - parameters:
///   - under: the search path, e.g. NSSearchPathDirectory.LibraryDirectory
/// - returns: a NSURL to the directory
internal func dirURL(
	under: NSSearchPathDirectory)
	-> NSURL
{
	return fileManager.URLsForDirectory(under, inDomains: .UserDomainMask)[0]
}
///
/// Create a top level subdirectory under the the "under" NSsearchDirectory.
///
/// - parameters:
///   - dir: the name of the sub directory
///   - under: the search path, e.g. NSSearchPathDirectory.LibraryDirectory
/// - returns: a NSURL to the directory
internal func createSubDir(
	dir subDirName: String,
	under: NSSearchPathDirectory)
	-> NSURL
{
	let subDir = dirURL(under).URLByAppendingPathComponent(subDirName);
	do {
		try fileManager.createDirectoryAtURL(subDir,
			withIntermediateDirectories: true, attributes: nil);
	}
	catch {
		print("Could not create dir at the specified location");
	}
	return subDir;
}

///
/// Create a subdirectory under the passed NSURL.
///
/// - parameters:
///   - dir: the name of the sub directory
///   - parent: the parent NSURL
/// - returns: a NSURL to the directory
internal func createSubDirUnderParent(
	dir subDirName: String,
	parent: NSURL)
	-> NSURL
{
	let subDir = parent.URLByAppendingPathComponent(subDirName);
	do {
		try fileManager.createDirectoryAtURL(subDir,
			withIntermediateDirectories: true, attributes: nil);
	}
	catch {
		print("Could not create dir at the specified location");
	}
	return subDir;
}

///
/// Delete the file at the specified NSURL
///
/// - parameters
///  - file the file to delete
/// - returns true if the deletion succeeeded
///
internal func deleteFile(
	file fileToDeleteURL: NSURL)
	-> Bool
{
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

///
/// Copy a file from 'srcPath' to 'toPath'
///
/// - parameters:
///   - srcPath: the source NSURL
///   - toPath: the destination NSURL
/// - returns: was the copying successful
internal func myCopy(
	srcPath: NSURL,
	toPath: NSURL)
	-> Bool
{
	do {
		if let srcPath = srcPath.path, let toPath = toPath.path {
			try fileManager.copyItemAtPath(srcPath, toPath: toPath)
			return true
		}
	} catch {
		print("Error copying a file");
	}
	
	return false;
}
///
/// Move a file from 'srcPath' to 'toPath'
///
/// - parameters:
///   - srcPath: the source NSURL
///   - toPath: the destination NSURL
/// - returns: was the move successful
internal func myMove(
	srcPath: NSURL,
	toPath: NSURL)
	-> Bool
{
	do {
		try fileManager.moveItemAtURL(srcPath, toURL: toPath)
		return true;
	} catch {
		print("Fail moving \(srcPath.absoluteURL) to \(toPath)");
	}
	debugPrint("Failed to move");
	return false;
}

///
/// See if file exists
///
internal func fileExists(
	fileURL: NSURL)
	-> Bool
{
	if let filePath = fileURL.path {
		return fileManager.fileExistsAtPath(filePath)
	} else {
		return false;
	}
}

///
/// Check if NSURL is a directory
///
internal func fileIsDir(
	fileURL: NSURL)
	-> Bool
{
	var isDir: ObjCBool = false;
	fileManager.fileExistsAtPath(fileURL.path!, isDirectory: &isDir)
	return Bool(isDir);
}

///
/// Check if a path is a directory
///
internal func fileIsDir(
	path: String)
	-> Bool
{
	var isDir: ObjCBool = false;
	fileManager.fileExistsAtPath(path, isDirectory: &isDir)
	return Bool(isDir);
}
