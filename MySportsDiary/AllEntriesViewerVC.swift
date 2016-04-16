//
//  AllEntriesViewerVC.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 11/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import UIKit

class AllEntriesViewerVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

	@IBOutlet weak var tableView: UITableView!

	let eventCellContentIdentifier = "eventCellContent"
	let eventCellHeaderIdentifier = "eventCellHeader"
	let newEntryCellIdentifier = "newEntryCellIdentifier"

	var entries: [Entry]? = nil;
	var entryIndex: Int?;

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated);
		self.navigationController?.navigationBarHidden = true ;
		entries = DataManagerInstance().getEntries();
		tableView.reloadData();
	}
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return (entries?.count ?? 0) + 1;
	}
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

		if let entries = entries where entries.count > 0 && indexPath.row < entries.count {
			return;
		} else {
			self.tabBarController?.selectedIndex = 2;
			if let vc = self.tabBarController?.viewControllers?[2] as? UINavigationController {
				vc.popToRootViewControllerAnimated(false);
			}
		}
	}

	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

		if let entries = entries where entries.count > indexPath.row {
			let cell = tableView.dequeueReusableCellWithIdentifier(eventCellContentIdentifier, forIndexPath: indexPath)
			let entryIndex = indexPath.row ;
			if 0 <= entryIndex && entries.count > entryIndex {
				let entry = entries[entryIndex]
				let date = stringDate(entry.date_time);
				cell.detailTextLabel?.text = screenDateString(date);
				cell.textLabel?.text = entry.skill
			}
			return cell;
		} else {
			return tableView.dequeueReusableCellWithIdentifier(newEntryCellIdentifier, forIndexPath: indexPath);
		}
	}

	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1;
	}

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if let vc = segue.destinationViewController as? SingleEntryViewerVC,
			let entries = self.entries,
			let cell = sender as? UITableViewCell,
			let row = tableView.indexPathForCell(cell)?.row
		where entries.count >= row && 0 <= row {
			let entry = entries[row];
			vc.entryType = .Existing;
			vc.entry = entry;
		}
	}
}
