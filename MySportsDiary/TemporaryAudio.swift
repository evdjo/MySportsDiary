//
//  TemporaryAudio.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 10/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation

class TemporaryAudio {

	///
	/// Gets a pair of :
	///
	///
	/// -- NSURL to the temporary audio file
	///
	/// -- Bool flag indicating whether the file exists
	///
	static func getTempAudio() -> NSURL? {
		return fileExists(TEMP_AUDIO_URL) ? TEMP_AUDIO_URL : nil;
	}

	///
	/// Sets the temporary audio file. If nil is passed, the file is deleted.
	///
	static func setTempAudio(newAudio: NSURL?) {
		if fileExists(TEMP_AUDIO_URL) {
			deleteFile(file: TEMP_AUDIO_URL);
		}
		if let newAudio = newAudio {
			myCopy(newAudio, toPath: TEMP_AUDIO_URL);
		}
	}

	///
	/// Deletes the temporary audio file.
	/// Equivalent to calling the setTempAudio and passing nil.
	///
	static func purgeTempAudio() {
		setTempAudio(nil);
	}
}