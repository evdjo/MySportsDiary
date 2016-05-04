//
//  TemporaryImages.swift
//  MyRugbyDiary
//
//  Created by Evdzhan Mustafa on 31/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation
import UIKit

class ImagesIO {

	///
	/// Gets list of all images uner parentDIR.
	/// returns Array of all UIImages if there are temp images saved,
	/// else will return nil.
	///
	static func getImages(parentDir: NSURL) -> Array<UIImage>? {
		do {
			if let path = parentDir.path {
				let files = try fileManager.contentsOfDirectoryAtPath(path);
				var images = Array<UIImage>();
				for file in files {
					if let path = parentDir .URLByAppendingPathComponent(file).path,
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
	/// Returns count of all images added in the parentDir.
	///
	static func getImagesCount(parentDir: NSURL) -> Int {
		do {
			if let path = parentDir.path {
				let files = try fileManager.contentsOfDirectoryAtPath(path);
				return files.count;
			}
		} catch {
			/// todo error handling
		}
		return 0;
	}

	///
	/// Saves the images under parentDIR url.
	// The image will later be available in the
	/// array returned by getTempImages() function.
	///
	static func saveImage(parentDir: NSURL, image: UIImage) {
		let path = parentDir.URLByAppendingPathComponent("\(timestamp()).png");
		UIImagePNGRepresentation(image)?.writeToURL(path, atomically: true);
	}

	///
	/// Removes a image with the specified index.
	///
	static func removeImage(parentDir: NSURL, index: Int) {
		do {
			if let path = parentDir.path {
				let files = try fileManager.contentsOfDirectoryAtPath(path);
				if files.count > index {
					deleteFile(file: parentDir.URLByAppendingPathComponent(files[index]))
				}
			}
		} catch {
			/// todo error handling
		}
	}
	///
	/// CAUTION -- Deletes all from the parent 'images' folder
	///
	static func purgeImages(parentDir: NSURL) {
		do {
			if let path = parentDir.path {
				let files = try fileManager.contentsOfDirectoryAtPath(path);
				for file in files {
					deleteFile(file: parentDir.URLByAppendingPathComponent(file));
				}
			}
		} catch {
			/// todo error handling
		}
	}
}