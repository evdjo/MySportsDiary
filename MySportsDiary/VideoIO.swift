//
//  TemporaryVideo.swift
//  MyRugbyDiary
//
//  Created by Evdzhan Mustafa on 10/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation

class VideoIO {

	///
	/// Gets the oldVideo video if it exists.
	/// If it was not set before, nil is returned.
	///
	static func getVideo(oldVideo oldVideo: NSURL) -> NSURL? {
		return fileExists(oldVideo) ? oldVideo : nil;
	}
///
/// Sets the oldVideo to be the newVideo by copyinng over the old one.
/// If the passed argument is nil, the oldVideo is simply deleted.
///
	static func setVideo(oldVideo oldVideo: NSURL, newVideo: NSURL?) {
		if fileExists(oldVideo) {
			deleteFile(file: oldVideo);
		}
		if let newVideo = newVideo {
			myCopy(newVideo, toPath: oldVideo);
		}
	}
///
/// Deletes the video file under parentDir .
/// Equivalent to callign setTempVideo with with nil argument.
///
	static func purgeVideo(oldVideo oldVideo: NSURL) {
		setVideo(oldVideo: oldVideo, newVideo: nil);
	}
}