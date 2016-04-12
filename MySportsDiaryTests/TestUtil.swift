//
//  TestUtil.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 11/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation

internal func allASCIICharsAsString() -> String {
	var str = "";
	for i in 32 ... 126 {
		str.append(Character(UnicodeScalar(i)))
	}
	print(str);
	return str;
}

internal let NORMAL_STRING = "NORMAL STRING";
internal let DOUBLES = [12.3456, 9.8765, 1.1111, 5.4321];
internal let PHOTOS = [
	["photo1.png", NORMAL_STRING, "photo2.png", "photo3.png"],
	["ImaGe.png", allASCIICharsAsString(), "PhoTO.jpeg", "IMG.png"],
	["JPEG.png", "", "Dog.png", "What__Z?.png"]
];

internal let AUDIO = [
	"audio.caf",
	"recording.caf",
	"sound.caf"
];

internal let VIDEO = [
	"mov.MOV",
	"recording.MOV",
	"video.MOV"
];