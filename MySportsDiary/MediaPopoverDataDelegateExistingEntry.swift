//
//  MediaPopoverDataDelegateExistingEntry.swift
//  MyRugbyDiary
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
		let dir = DataConfig.ENTRIES_DIR_URL.URLByAppendingPathComponent(entryTime)
			.URLByAppendingPathComponent(DataConfig.IMAGES);
		DataManagerInstance().saveImage(dir, image: image)
	}
	func images() -> [UIImage]? {
		let entryTime = entry.date_time;
		let dir = DataConfig.ENTRIES_DIR_URL.URLByAppendingPathComponent(entryTime)
			.URLByAppendingPathComponent(DataConfig.IMAGES);
		return DataManagerInstance().getImages(dir)
	}
	func removeImage(index: Int) -> Void {
		let entryTime = entry.date_time;
		let dir = DataConfig.ENTRIES_DIR_URL.URLByAppendingPathComponent(entryTime)
			.URLByAppendingPathComponent(DataConfig.IMAGES);
		return DataManagerInstance().removeImage(dir, index: index);
	}

	func getImagesCount() -> Int {
		let entryTime = entry.date_time;
		let dir = DataConfig.ENTRIES_DIR_URL.URLByAppendingPathComponent(entryTime)
			.URLByAppendingPathComponent(DataConfig.IMAGES);
		return DataManagerInstance().getImagesCount(dir);
	}

	var video: NSURL? {
		set {
			let entryTime = entry.date_time;
			let dir = DataConfig.ENTRIES_DIR_URL.URLByAppendingPathComponent(entryTime)
				.URLByAppendingPathComponent(DataConfig.VIDEO);
			DataManagerInstance().setVideo(oldVideo: dir, newVideo: newValue)
		}
		get {
			let entryTime = entry.date_time;
			let dir = DataConfig.ENTRIES_DIR_URL.URLByAppendingPathComponent(entryTime)
				.URLByAppendingPathComponent(DataConfig.VIDEO);
			return DataManagerInstance().getVideo(oldVideo: dir)
		}
	}

	var audio: NSURL? {
		set {
			let entryTime = entry.date_time;
			let dir = DataConfig.ENTRIES_DIR_URL.URLByAppendingPathComponent(entryTime)
				.URLByAppendingPathComponent(DataConfig.AUDIO);
			DataManagerInstance().setAudio(oldAudio: dir, newAudio: newValue)
		}
		get {
			let entryTime = entry.date_time;
			let dir = DataConfig.ENTRIES_DIR_URL.URLByAppendingPathComponent(entryTime)
				.URLByAppendingPathComponent(DataConfig.AUDIO);
			return DataManagerInstance().getAudio(oldAudio: dir)
		}
	}
}