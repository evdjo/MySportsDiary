//
//  AllEntriesViewerVC.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 11/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import UIKit

class AllEntriesViewerVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
/// The table view shows all the entries added so far.
	@IBOutlet weak var tableView: UITableView!

// The cell identifiers
	let eventCellContentIdentifier = "eventCellContent"
	let eventCellHeaderIdentifier = "eventCellHeader"
	let newEntryCellIdentifier = "newEntryCellIdentifier"

/// The list of entries
	var entries: EntriesByDate!;

/// On appear load all the entries from the db
/// Then show them on the tableview.
/// The explicit reloadData is called, because if the view controller
/// appears from navigation, let's say, the table won't reload itself.
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated);
		self.navigationController?.navigationBarHidden = true ;
		refreshEntries();
	}
	private func refreshEntries() {
		entries = DataManagerInstance().getEntriesByDate();
		tableView.reloadData();
	}
/// The count of table cells, is the number of entries + 1.
/// The last table cell, is the add new entry button.
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard nil != entries else { return 0; }
		switch section {
		case 0: return entries.todayEntries.count;
		case 1: return entries.weekEntries.count;
		case 2: return entries.olderEntries.count;
		default: return 0;
		}
	}

	func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		guard nil != entries else { return nil; }
		switch section {
		case 0: return "Today(\(entries.todayEntries.count))";
		case 1: return "This week(\(entries.weekEntries.count))"
		case 2: return "Older(\(entries.olderEntries.count))";
		default: return nil;
		}
	}

/// The cell of each entry.
/// Simply fetch the entry's skill and date.
/// That's what we show for now.
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier(eventCellContentIdentifier, forIndexPath: indexPath)
		if let entry = entryForIndexPath(indexPath) {
			let date = stringDate(entry.date_time);
			cell.detailTextLabel?.text = screenDateString(date);
			cell.textLabel?.text = entry.skill
		}
		return cell;
	}

/// Three sections -- today's entries, this weeks entries, and older.
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 3;
	}
/// When we press a entry cell, we set the entry of the SingleEntryViewerVC
/// We also set it's type of .Existing.
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if let vc = segue.destinationViewController as? SingleEntryViewerVC,
			let cell = sender as? UITableViewCell,
			let indexPath = tableView.indexPathForCell(cell) {
				vc.entry = entryForIndexPath(indexPath);
				vc.entryType = .Existing;
		}
	}

	private func entryForIndexPath(indexPath: NSIndexPath) -> Entry? {
		let row = indexPath.row;

		switch indexPath.section {
		case 0:
			if 0 <= row && row < entries.todayEntries.count {
				return entries.todayEntries[indexPath.row];
			}
		case 1:
			if 0 <= row && row < entries.weekEntries.count {
				return entries.weekEntries[indexPath.row];
			}
		case 2:
			if 0 <= row && row < entries.olderEntries.count {
				return entries.olderEntries[indexPath.row];
			}
		default: break;
		}
		return nil;
	}
}
