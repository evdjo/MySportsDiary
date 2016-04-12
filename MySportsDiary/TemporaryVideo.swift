//
//  TemporaryVideo.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 10/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation

class TemporaryVideo {

	///
	/// Gets the temporary video file URL.
	/// If it was not set before, nil is returned.
	///
	static func getTempVideo() -> NSURL? {
		let video = TEMP_VIDEO_URL;
		if fileExists(TEMP_VIDEO_URL) {
			return video;
		}
		return nil;
	}
	///
	/// Sets the temporary video file.
	/// If the passed argument is nil, the existing video file is simply deleted.
	/// If the passed argument is existing video, will copy over the existing.
	///
	static func setTempVideo(videoURL: NSURL?) {
		let url = TEMP_VIDEO_URL;
		if fileExists(url) {
			deleteFile(file: TEMP_VIDEO_URL);
		}
		if let videoURL = videoURL {
			myCopy(videoURL, toPath: url);
		}
	}
	///
	/// Deletes the temporary video file.
	/// Equivalent to callign setTempVideo with with nil argument.
	///
	static func purgeTempVideo() {
		self.setTempVideo(nil);
	}
}