//
//  SecondViewController.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 11/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import UIKit

class EntriesViewerVC: UIViewController, UITableViewDelegate,
UITableViewDataSource, MediaDelegate {

	@IBOutlet weak var tableView: UITableView!

	let eventCellContentIdentifier = "eventCellContent"
	let eventCellHeaderIdentifier = "eventCellHeader"

	var entries: [Entry]? = nil;
	var entryIndex: Int?;

	override func viewDidLoad() {
		super.viewDidLoad();
	}

//	override func didReceiveMemoryWarning() {
//		super.didReceiveMemoryWarning();
//		entries = nil;
//	}

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated);
		self.navigationController?.navigationBarHidden = true ;
		entries = DataManagerInstance().getEntries();
		tableView.reloadData();
	}
	override func viewWillDisappear(animated: Bool) {
		super.viewWillDisappear(animated);
		self.navigationController?.navigationBarHidden = false;
	}

	func tableView(tableView: UITableView,
		numberOfRowsInSection section: Int) -> Int {
			if section == 1 {
				return entries?.count ?? 0;
			} else {
				return 1;
			}
	}

	func tableView(tableView: UITableView,
		cellForRowAtIndexPath indexPath: NSIndexPath)
		-> UITableViewCell {
			let row = indexPath.row;
			let section = indexPath.section;

			if (section == 0) {
				let cell = tableView.dequeueReusableCellWithIdentifier(
					eventCellHeaderIdentifier, forIndexPath: indexPath)
				cell.textLabel?.text = "ENTRIES";
				cell.textLabel?.textAlignment = .Center;
				return cell;
			} else {

				let cell = tableView.dequeueReusableCellWithIdentifier(
					eventCellContentIdentifier, forIndexPath: indexPath)
				if let entries = entries where entries.count > row {
					let entry = entries[indexPath.row]
					let date = stringDate(entry.date_time);
					cell.detailTextLabel?.text = screenDateString(date);
					cell.textLabel?.text = entry.skill
				}
				return cell;
			}
	}

	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 2;
	}

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if let vc = segue.destinationViewController as? EntrySecondScreen,
			let cell = sender as? UITableViewCell,
			let index = tableView.indexPathForCell(cell) {
				entryIndex = index.row;
				vc.mediaDelegate = self;
		}
	}

	func newImage(image: UIImage) -> Void {
		let entry = entries![entryIndex!]
		let entryTime = entry.date_time;
		let dir = ENTRIES_DIR_URL.URLByAppendingPathComponent(entryTime).URLByAppendingPathComponent("images");
		TemporaryImages.saveTempImage(image, toPath: dir);
	}
	func images() -> [UIImage]? { return nil }
	func removeImage(index: Int) -> Void { }

	var video: NSURL? {
		set { }
		get { return nil }
	}

	var audio: NSURL? {
		set { }
		get { return nil }
	}
}
