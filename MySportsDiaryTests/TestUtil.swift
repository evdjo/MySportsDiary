//
//  TestUtil.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 11/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation
internal func allASCIICharsAsString() -> String {
	var str = "";
	for i in 32 ... 126 {
		str.append(Character(UnicodeScalar(i)))
	}
	print(str);
	return str;
}

internal let NORMAL_STRING = "NORMAL STRING";
internal let DOUBLES = [12.3456, 9.8765, 1.1111, 5.4321];
internal let PHOTOS = [
	["photo1.png", NORMAL_STRING, "photo2.png", "photo3.png"],
	["ImaGe.png", allASCIICharsAsString(), "PhoTO.jpeg", "IMG.png"],
	["JPEG.png", "", "Dog.png", "What__Z?.png"]
];

internal let AUDIO = [
	"audio.caf",
	"recording.caf",
	"sound.caf"
];

internal let VIDEO = [
	"mov.MOV",
	"recording.MOV",
	"video.MOV"
];

///
/// Check if NSURL is a directory
///
func fileIsDir(fileURL: NSURL) -> Bool {
	var isDir: ObjCBool = false;
	manager.fileExistsAtPath(fileURL.path!, isDirectory: &isDir)
	return Bool(isDir);
}

///
/// Check if a path is a directory
///
func fileIsDir(path: String) -> Bool {
	var isDir: ObjCBool = false;
	manager.fileExistsAtPath(path, isDirectory: &isDir)
	return Bool(isDir);
}

let manager = NSFileManager.defaultManager();

func deleteEveryThingUnder(under: NSSearchPathDirectory) {
	let fileURL = manager.URLsForDirectory(under, inDomains: .UserDomainMask)[0];
	deleteInDir(fileURL);
}
func deleteInDir(parentURL: NSURL) {
	let parentPATH = parentURL.path!
	if let files = try? NSFileManager.defaultManager()
		.contentsOfDirectoryAtPath(parentPATH) {
			for file in files {
				let isDir = fileIsDir(parentURL.URLByAppendingPathComponent(file));
				if (isDir && (file == "Caches" || file == "Preferences")) { /// don't delete default folders, but delete their contets
					deleteInDir(parentURL.URLByAppendingPathComponent(file));
				} else {
					try! manager.removeItemAtURL(parentURL.URLByAppendingPathComponent(file))
				}
			}
	}
}