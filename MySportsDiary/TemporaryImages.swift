//
//  TemporaryImages.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 31/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation
import UIKit

class TemporaryImages {

	static private let tempImagesDir = "tempImages";
	static private let tempImagesUnder: NSSearchPathDirectory = .CachesDirectory;
	static private var tempImagesDirURL = createSubDir(dir: tempImagesDir, under: tempImagesUnder);

	static private let entryImagesDir = "entryImages"
	static private let entryImageUnder: NSSearchPathDirectory = .LibraryDirectory;
	static private var entryImagesDirURL = createSubDir(dir: entryImagesDir, under: entryImageUnder);

	///
	/// Gets list of all temp images.
	/// returns Array of all UIImages if there are temp images saved,
	/// else will return nil.
	///
	static func getTempImages() -> Array<UIImage>? {
		do {
			if let path = tempImagesDirURL.path {
				let files = try fileManager.contentsOfDirectoryAtPath(path);
				var images = Array<UIImage>();
				for file in files {
					if let image = UIImage(contentsOfFile: tempImagesDirURL
							.URLByAppendingPathComponent(file).path!) {
								images.append(image);
					}
				}
				return images;
			}
		} catch {
			/// todo error handling
		}
		return nil;
	}

	///
	/// Returns count of all temp images.
	///
	static func getImagesCount() -> Int {
		do {
			if let path = tempImagesDirURL.path {
				let files = try fileManager.contentsOfDirectoryAtPath(path);
				return files.count;
			}
		} catch {
			/// todo error handling
		}
		return 0;
	}

	///
	/// Saves a temporary images. The image will later be available in the
	/// array returned by getTempImages() function.
	///
	static func saveTempImage(image: UIImage) {
		let path = tempImagesDirURL.URLByAppendingPathComponent(timestamp());
		UIImagePNGRepresentation(image)?.writeToURL(path, atomically: true);
	}

	///
	/// Removes a temporary image with the specified index.
	///
	static func removeTempImage(index: Int) {
		do {
			if let path = tempImagesDirURL.path {
				let files = try fileManager.contentsOfDirectoryAtPath(path);
				if files.count > index {
					deleteFile(file: tempImagesDirURL.URLByAppendingPathComponent(files[index]))
				}
			}
		} catch {
			/// todo error handling
		}
	}
	///
	/// CAUTION -- Deletes all images.
	///
	static func purgeImages() {
		deleteFile(file: tempImagesDirURL)
		tempImagesDirURL = createSubDir(dir: tempImagesDir, under: .CachesDirectory)
	}

	static func moveTempImages(toDir dir: String) -> NSURL {
		let destination = entryImagesDirURL.URLByAppendingPathComponent(dir);
		myMove(tempImagesDirURL, toPath: destination)
		return destination;
	}
}