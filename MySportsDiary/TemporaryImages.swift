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

	///
	/// Gets list of all temp images.
	/// returns Array of all UIImages if there are temp images saved,
	/// else will return nil.
	///
	static func getTempImages() -> Array<UIImage>? {
		do {
			if let path = TEMP_IMAGES_URL.path {
				let files = try fileManager.contentsOfDirectoryAtPath(path);
				var images = Array<UIImage>();
				for file in files {
					if let path = TEMP_IMAGES_URL
						.URLByAppendingPathComponent(file).path,
						let image = UIImage(contentsOfFile: path) {
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
			if let path = TEMP_IMAGES_URL.path {
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
	static func saveTempImage(image: UIImage, toPath: NSURL = TEMP_IMAGES_URL) {
		let path = toPath.URLByAppendingPathComponent(timestamp());
		UIImagePNGRepresentation(image)?.writeToURL(path, atomically: true);
	}

	///
	/// Removes a temporary image with the specified index.
	///
	static func removeTempImage(index: Int) {
		do {
			if let path = TEMP_IMAGES_URL.path {
				let files = try fileManager.contentsOfDirectoryAtPath(path);
				if files.count > index {
					deleteFile(file: TEMP_IMAGES_URL.URLByAppendingPathComponent(files[index]))
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
		do {
			if let path = TEMP_IMAGES_URL.path {
				let files = try fileManager.contentsOfDirectoryAtPath(path);
				for file in files {
					deleteFile(file: TEMP_IMAGES_URL.URLByAppendingPathComponent(file));
				}
			}
		} catch {
			/// todo error handling
		}
	}
}