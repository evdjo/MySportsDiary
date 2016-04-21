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
		DataManagerInstance().saveImage(DataConfig.TEMP_IMAGES_URL, image: image)
	}
	func images() -> [UIImage]? {
		return DataManagerInstance().getImages(DataConfig.TEMP_IMAGES_URL)
	}
	func removeImage(index: Int) -> Void {
		DataManagerInstance().removeImage(DataConfig.TEMP_IMAGES_URL, index: index)
	}
	func getImagesCount() -> Int {
		return DataManagerInstance().getImagesCount(DataConfig.TEMP_IMAGES_URL);
	}

	var video: NSURL? {
		set {
			DataManagerInstance().setVideo(oldVideo: DataConfig.TEMP_VIDEO_URL, newVideo: newValue)
		}
		get {
			return DataManagerInstance().getVideo(oldVideo: DataConfig.TEMP_VIDEO_URL)
		}
	}

	var audio: NSURL? {
		set {
			DataManagerInstance().setAudio(oldAudio: DataConfig.TEMP_AUDIO_URL, newAudio: newValue)
		}
		get {
			return DataManagerInstance().getAudio(oldAudio: DataConfig.TEMP_AUDIO_URL)
		}
	}

	func move(destination dir: NSURL) {
		myMove(DataConfig.TEMP_DIR_URL, toPath: dir);
		createSubDir(dir: DataConfig.TEMP_MEDIA, under: DataConfig.TEMP_DIR_LOCATION)
		createSubDirUnderParent(dir: DataConfig.IMAGES, parent: DataConfig.TEMP_DIR_URL)
	}
}
