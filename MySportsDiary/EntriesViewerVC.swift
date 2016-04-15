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
	let newEntryCellIdentifier = "newEntryCellIdentifier"

	var entries: [Entry]? = nil;
	var entryIndex: Int?;

	override func viewDidLoad() {
		super.viewDidLoad();
	}

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

	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		return (entries?.count ?? 0) + 1;
	}
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

		if 0 == indexPath.row && 0 == indexPath.section {
			self.tabBarController?.selectedIndex = 2;
		}
	}

	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

		if 0 == indexPath.row {
			return tableView.dequeueReusableCellWithIdentifier(newEntryCellIdentifier, forIndexPath: indexPath);
		} else {

			let cell = tableView.dequeueReusableCellWithIdentifier(
				eventCellContentIdentifier, forIndexPath: indexPath)
			let entryIndex = indexPath.row - 1;
			if let entries = entries where 0 < entries.count && entries.count > entryIndex {
				let entry = entries[entryIndex]
				let date = stringDate(entry.date_time);
				cell.detailTextLabel?.text = screenDateString(date);
				cell.textLabel?.text = entry.skill
			}
			return cell;
		}
	}

	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1;
	}

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if let vc = segue.destinationViewController as? EntrySecondScreen,
			let cell = sender as? UITableViewCell,
			let index = tableView.indexPathForCell(cell) {
				entryIndex = index.row - 1;
				vc.mediaDelegate = self;
				vc.topLabelText = entries![entryIndex!].skill
				vc.entryDescription = entries![entryIndex!].description;
		}
	}

	func newImage(image: UIImage) -> Void {
		let entry = entries![entryIndex!]
		let entryTime = entry.date_time;
		let dir = ENTRIES_DIR_URL.URLByAppendingPathComponent(entryTime).URLByAppendingPathComponent("images");
		DataManagerInstance().saveImage(dir, image: image)
	}
	func images() -> [UIImage]? {
		let entry = entries![entryIndex!]
		let entryTime = entry.date_time;
		let dir = ENTRIES_DIR_URL.URLByAppendingPathComponent(entryTime).URLByAppendingPathComponent("images");
		return DataManagerInstance().getImages(dir)
	}
	func removeImage(index: Int) -> Void {
		let entry = entries![entryIndex!]
		let entryTime = entry.date_time;
		let dir = ENTRIES_DIR_URL.URLByAppendingPathComponent(entryTime).URLByAppendingPathComponent("images");
		return DataManagerInstance().removeImage(dir, index: index);
	}

	var video: NSURL? {
		set {
			let entry = entries![entryIndex!]
			let entryTime = entry.date_time;
			let dir = ENTRIES_DIR_URL.URLByAppendingPathComponent(entryTime).URLByAppendingPathComponent("video.MOV");
			DataManagerInstance().setVideo(oldVideo: dir, newVideo: newValue)
		}
		get {
			let entry = entries![entryIndex!]
			let entryTime = entry.date_time;
			let dir = ENTRIES_DIR_URL.URLByAppendingPathComponent(entryTime).URLByAppendingPathComponent("video.MOV");
			return DataManagerInstance().getVideo(oldVideo: dir)
		}
	}

	var audio: NSURL? {
		set {
			let entry = entries![entryIndex!]
			let entryTime = entry.date_time;
			let dir = ENTRIES_DIR_URL.URLByAppendingPathComponent(entryTime).URLByAppendingPathComponent("audio.caf");
			DataManagerInstance().setAudio(oldAudio: dir, newAudio: newValue)
		}
		get {
			let entry = entries![entryIndex!]
			let entryTime = entry.date_time;
			let dir = ENTRIES_DIR_URL.URLByAppendingPathComponent(entryTime).URLByAppendingPathComponent("audio.caf");
			return DataManagerInstance().getAudio(oldAudio: dir)
		}
	}
}
