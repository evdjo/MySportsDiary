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
    static private let tempImagesDirURL = createSubDir(dir: tempImagesDir, under: .CachesDirectory);
    
    ///
    /// Save image to a temp folder
    ///
    static func setTempImages(images: Array<UIImage>) {
        try! fileManager.removeItemAtURL(tempImagesDirURL);
        if(images.count < 1) { return; }
        createSubDir(dir: tempImagesDir, under: .CachesDirectory);
        for i in 0...images.count - 1 {
            let path = tempImagesDirURL.URLByAppendingPathComponent(String(i));
            UIImagePNGRepresentation(images[i])?.writeToURL(path, atomically: true);
        }
    }
    
    static func getTempImages() -> Array<UIImage>? {
        do {
            if let path = tempImagesDirURL.path {
                let files =  try fileManager.contentsOfDirectoryAtPath(path);
                var images = Array<UIImage>();
                for file in files {
                    if let image = UIImage(contentsOfFile: tempImagesDirURL.URLByAppendingPathComponent(file).path!) {
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
    
    static func saveTempImage(image: UIImage) {
        let path = tempImagesDirURL.URLByAppendingPathComponent(timestamp());
        UIImagePNGRepresentation(image)?.writeToURL(path, atomically: true);
    }
    
    static func removeTempImage(index: Int) {
        do {
            if let path = tempImagesDirURL.path {
                let files =  try fileManager.contentsOfDirectoryAtPath(path);
                if files.count > index {
                    deleteFile(file: tempImagesDirURL.URLByAppendingPathComponent(files[index]))
                }
            }
        } catch {
            /// todo error handling
        }
        
    }
    
    
    
    
}