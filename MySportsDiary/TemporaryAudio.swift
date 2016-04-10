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
    /// Defines the temporary audio URL.
    ///
	static private func tempAudioURL() -> NSURL {
		return fileURL(file: "audio.caf", under: .CachesDirectory);
	}

	///
	/// Gets a pair of :
	/// -- NSURL to the temporary audio file
	/// -- Bool flag indicating whether the file exists
	///
	static func getTempAudio() -> (url: NSURL, exists: Bool) {
		let audio = tempAudioURL();
		return (audio, fileExists(audio))
	}

	///
	/// Sets the temporary audio file. If nil is passed, the file is deleted.
	///
	static func setTempAudio(newAudio: NSURL?) {
		let audioFile = getTempAudio();
		if audioFile.exists {
			deleteFile(file: audioFile.url);
		}
		if let newAudio = newAudio {
			myCopy(newAudio, toPath: audioFile.url);
		}
	}

	///
	/// Deletes the temporary audio file.
	/// Equivalent to calling the setTempAudio and passing nil.
	///
	static func purgeTempAudio() {
		self.setTempAudio(nil);
	}
}