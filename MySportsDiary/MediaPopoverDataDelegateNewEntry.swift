//
//  MediaPopoverDataDelegateNewEntry.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 13/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation
import UIKit
class MediaPopoverDataDelegateNewEntry: MediaPopoverDataDelegate {

	func newImage(image: UIImage) -> Void {
		DataManagerInstance().saveImage(TEMP_IMAGES_URL, image: image)
	}
	func images() -> [UIImage]? {
		return DataManagerInstance().getImages(TEMP_IMAGES_URL)
	}
	func removeImage(index: Int) -> Void {
		DataManagerInstance().removeImage(TEMP_IMAGES_URL, index: index)
	}
	func getImagesCount() -> Int {
		return DataManagerInstance().getImagesCount(TEMP_IMAGES_URL);
	}

	var video: NSURL? {
		set {
			DataManagerInstance().setVideo(oldVideo: TEMP_VIDEO_URL, newVideo: newValue)
		}
		get {
			return DataManagerInstance().getVideo(oldVideo: TEMP_VIDEO_URL)
		}
	}

	var audio: NSURL? {
		set {
			DataManagerInstance().setAudio(oldAudio: TEMP_AUDIO_URL, newAudio: newValue)
		}
		get {
			return DataManagerInstance().getAudio(oldAudio: TEMP_AUDIO_URL)
		}
	}

	func move(destination dir: NSURL) {
		myMove(TEMP_DIR_URL, toPath: dir);
		createSubDir(dir: TEMP_MEDIA, under: TEMP_DIR_LOCATION)
		createSubDirUnderParent(dir: IMAGES, parent: TEMP_DIR_URL)
	}
}
