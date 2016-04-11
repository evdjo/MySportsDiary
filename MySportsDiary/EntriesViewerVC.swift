//
//  SecondViewController.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 11/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import UIKit

class EntriesViewerVC: UIViewController, UITableViewDelegate,
UITableViewDataSource {

	@IBOutlet weak var tableView: UITableView!

	let identifier = "eventCellIdentifier"

	var entries: [Entry]? = nil;

	override func viewDidLoad() {
		super.viewDidLoad();
	}

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated);
		entries = DataManagerInstance().getEntries();
		print(entries);
	}

	func tableView(tableView: UITableView,
		numberOfRowsInSection section: Int) -> Int {
			return entries?.count ?? 0;
	}

	func tableView(tableView: UITableView,
		cellForRowAtIndexPath indexPath: NSIndexPath)
		-> UITableViewCell {
			let cell = tableView.dequeueReusableCellWithIdentifier(identifier,
				forIndexPath: indexPath)
			if let entries = entries where entries.count > indexPath.row {
				cell.detailTextLabel?.text = entries[indexPath.row].skill
				cell.textLabel?.text = entries[indexPath.row].description
			}
			return cell;
	}
}

struct Entry {
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
	return lhs.skill == rhs.skill &&
	lhs.description == rhs.description &&
	lhs.date_time == rhs.date_time &&
	lhs.latitude == rhs.latitude &&
	lhs.longitude == rhs.longitude
}
