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

	func newImage(image: UIImage) -> Void { DataManagerInstance().saveTempImage(image); }
	func images() -> [UIImage]? { return DataManagerInstance().getTempImages(); }
	func removeImage(index: Int) -> Void { DataManagerInstance().removeTempImage(index); }

	var video: NSURL? {
		set { DataManagerInstance().setTempVideo(newValue); }
		get { return DataManagerInstance().getTempVideo(); }
	}

	var audio: NSURL? {
		set { DataManagerInstance().setTempAudio(newValue); }
		get { return DataManagerInstance().getTempAudio(); }
	}
}