//
//  TemporaryAudio.swift
//  MyRugbyDiary
//
//  Created by Evdzhan Mustafa on 10/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation

class AudioIO {

	///
	/// Gets a the oldAudio or nil if it doesnt exist
	///
	static func getAudio(oldAudio oldAudio: NSURL) -> NSURL? {
		return fileExists(oldAudio) ? oldAudio : nil;
	}

	///
	/// Sets the audio file. If newAudio nil is passed, the audioURL file is deleted.
	///
	static func setAudio(oldAudio oldAudio: NSURL, newAudio: NSURL?) {
		if fileExists(oldAudio) {
			deleteFile(file: oldAudio);
		}
		if let newAudio = newAudio {
			myCopy(newAudio, toPath: oldAudio);
		}
	}

	///
	/// Deletes the oldAudio.
	///
	static func purgeAudio(oldAudio oldAudio: NSURL) {
		setAudio(oldAudio: oldAudio, newAudio: nil);
	}
}