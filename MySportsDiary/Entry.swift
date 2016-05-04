//
//  Entry.swift
//  MyRugbyDiary
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
}
extension Entry: Equatable { }
func == (lhs: Entry, rhs: Entry) -> Bool {
	return lhs.skill == rhs.skill &&
	lhs.description == rhs.description &&
	lhs.date_time == rhs.date_time &&
	lhs.latitude == rhs.latitude &&
	lhs.longitude == rhs.longitude
}
