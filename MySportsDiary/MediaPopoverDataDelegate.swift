//
//  MediaPopoverDataDelegate.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 13/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation
import UIKit

///
/// Persists the media saved/required by the popovers
//
protocol MediaPopoverDataDelegate: class {

	func newImage(image: UIImage);
	func images() -> [UIImage]?;
	func removeImage(index: Int);

	var video: NSURL? { get set }

	var audio: NSURL? { get set }
}


