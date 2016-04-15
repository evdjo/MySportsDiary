//
//  NewEntryMediaDelegate.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 13/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation
import UIKit
class NewEntryMediaDelegate: MediaDelegate {

	func newImage(image: UIImage) -> Void { DataManagerInstance().saveImage(NewEntryMediaDelegate.TEMP_IMAGES_URL, image: image) }
	func images() -> [UIImage]? { return DataManagerInstance().getImages(NewEntryMediaDelegate.TEMP_IMAGES_URL) }
	func removeImage(index: Int) -> Void { DataManagerInstance().removeImage(NewEntryMediaDelegate.TEMP_IMAGES_URL, index: index) }

	var video: NSURL? {
		set { DataManagerInstance().setVideo(oldVideo: NewEntryMediaDelegate.TEMP_VIDEO_URL, newVideo: newValue) }
		get { return DataManagerInstance().getVideo(oldVideo: NewEntryMediaDelegate.TEMP_VIDEO_URL) }
	}

	var audio: NSURL? {
		set { DataManagerInstance().setAudio(oldAudio: NewEntryMediaDelegate.TEMP_AUDIO_URL, newAudio: newValue) }
		get { return DataManagerInstance().getAudio(oldAudio: NewEntryMediaDelegate.TEMP_AUDIO_URL) }
	}

	func copyOver(destination dir: NSURL) {
		myMove(NewEntryMediaDelegate.TEMP_DIR_URL, toPath: dir);
		createSubDir(dir: "temp_media", under: NewEntryMediaDelegate.TEMP_DIR_LOCATION)
		createSubDirUnderParent(dir: "images", parent: NewEntryMediaDelegate.TEMP_DIR_URL)
	}
	////
	/// TEMP MEDIA
	//
	private static let TEMP_DIR_LOCATION: NSSearchPathDirectory = .CachesDirectory
	private static let TEMP_DIR_URL = createSubDir(dir: "temp_media", under: TEMP_DIR_LOCATION);
	private static let TEMP_IMAGES_URL = createSubDirUnderParent(dir: "images", parent: TEMP_DIR_URL);
	private static let TEMP_AUDIO_URL = fileURLUnderParent(file: "audio.caf", parent: TEMP_DIR_URL);
	private static let TEMP_VIDEO_URL = fileURLUnderParent(file: "video.MOV", parent: TEMP_DIR_URL);
}
