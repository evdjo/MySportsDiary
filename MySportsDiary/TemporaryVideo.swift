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
    /// Defines the URL of the temporary video
    ///
	static private func tempVideoURL() -> NSURL {
		return fileURL(file: "temp_video.MOV", under: .CachesDirectory);
	}

	///
	/// Gets the temporary video file URL.
    /// If it was not set before, nil is returned.
	///
	static func getTempVideo() -> NSURL? {
		let video = tempVideoURL();
		if fileExists(video) {
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
		let url = tempVideoURL();
		if fileExists(url) {
			deleteFile(file: tempVideoURL());
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