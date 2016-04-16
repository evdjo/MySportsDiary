//
//  MediaPopoverDataDelegateExistingEntry.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 16/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation
import UIKit
class MediaPopoverDataDelegateExistingEntry: MediaPopoverDataDelegate {

	internal var entry: Entry;
	init(entry: Entry) {
		self.entry = entry;
	}
    
	func newImage(image: UIImage) -> Void {
		let entryTime = entry.date_time;
		let dir = ENTRIES_DIR_URL.URLByAppendingPathComponent(entryTime).URLByAppendingPathComponent("images");
		DataManagerInstance().saveImage(dir, image: image)
	}
	func images() -> [UIImage]? {
		let entryTime = entry.date_time;
		let dir = ENTRIES_DIR_URL.URLByAppendingPathComponent(entryTime).URLByAppendingPathComponent("images");
		return DataManagerInstance().getImages(dir)
	}
	func removeImage(index: Int) -> Void {
		let entryTime = entry.date_time;
		let dir = ENTRIES_DIR_URL.URLByAppendingPathComponent(entryTime).URLByAppendingPathComponent("images");
		return DataManagerInstance().removeImage(dir, index: index);
	}

	var video: NSURL? {
		set {
			let entryTime = entry.date_time;
			let dir = ENTRIES_DIR_URL.URLByAppendingPathComponent(entryTime).URLByAppendingPathComponent("video.MOV");
			DataManagerInstance().setVideo(oldVideo: dir, newVideo: newValue)
		}
		get {
			let entryTime = entry.date_time;
			let dir = ENTRIES_DIR_URL.URLByAppendingPathComponent(entryTime).URLByAppendingPathComponent("video.MOV");
			return DataManagerInstance().getVideo(oldVideo: dir)
		}
	}

	var audio: NSURL? {
		set {
			let entryTime = entry.date_time;
			let dir = ENTRIES_DIR_URL.URLByAppendingPathComponent(entryTime).URLByAppendingPathComponent("audio.caf");
			DataManagerInstance().setAudio(oldAudio: dir, newAudio: newValue)
		}
		get {
			let entryTime = entry.date_time;
			let dir = ENTRIES_DIR_URL.URLByAppendingPathComponent(entryTime).URLByAppendingPathComponent("audio.caf");
			return DataManagerInstance().getAudio(oldAudio: dir)
		}
	}
}