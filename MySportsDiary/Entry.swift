//
//  Entry.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 11/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation

struct Entry {
	let entry_id: Int64;
	let skill: String;
	let description: String;
	let date_time: String;
	let latitude: Double;
	let longitude: Double;
	var photos: [String]?;
	var audio: String?;
	var video: String?;
}
extension Entry: Equatable { }
func == (lhs: Entry, rhs: Entry) -> Bool {

	let photosEqual: Bool;
	if (lhs.photos == nil && rhs.photos == nil) {
		photosEqual = true; // both nil
	} else if let lphotos = lhs.photos, let rphotos = rhs.photos {
		photosEqual = lphotos == rphotos // both non nil
	} else {
		photosEqual = false; // one nil, one non nil
	}

	return lhs.skill == rhs.skill &&
	lhs.description == rhs.description &&
	lhs.date_time == rhs.date_time &&
	lhs.latitude == rhs.latitude &&
	lhs.longitude == rhs.longitude &&
	lhs.audio == rhs.audio &&
	lhs.video == rhs.video &&
	photosEqual
}
