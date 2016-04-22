//
//  AllEntriesViewerVC.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 11/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import UIKit
import QuartzCore

class AllEntriesViewerVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {
/// The table view shows all the entries added so far.
	@IBOutlet weak var tableView: UITableView!

// The cell identifiers
	let eventCellContentIdentifier = "eventCellContent"
	let eventCellHeaderIdentifier = "eventCellHeader"
	let newEntryCellIdentifier = "newEntryCellIdentifier"

/// The list of entries
	var entries: EntriesByDate!;

	var todayGestureRecognizer: UITapGestureRecognizer?;

	var showToday = true; // default true
	var showWeek = true; // default true
	var showOlder = true; // default true

///
/// On appear load all the entries from the db
/// Then show them on the tableview.
/// The explicit reloadData is called, because if the view controller
/// appears from navigation, let's say, the table won't reload itself.
///
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated);
		self.navigationController?.navigationBarHidden = true ;
		refreshEntries();
	}
///
/// Refetch entries from DB, and reload the tabeView
///
	private func refreshEntries() {
		entries = DataManagerInstance().getEntriesByDate();
		tableView.reloadData();
	}

///
/// The count of table cells, is the number of entries + 1.
/// The last table cell, is the add new entry button.
///
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard nil != entries else { return 0; }
		switch section {
		case 0: return showToday ? entries.todayEntries.count : 0;
		case 1: return showWeek ? entries.weekEntries.count : 0;
		case 2: return showOlder ? entries.olderEntries.count : 0;
		default: return 0;
		}
	}

	func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 35;
	}
	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return 40;
	}
///
/// The table headers are clickable and cause collapse/expand actions
///
	func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		guard nil != entries else { return nil; }
		var label: UILabel? = nil;

		switch section {
		case 0, 1, 2:
			label = UILabel.init(frame: CGRect(x: 0, y: 0, width: tableView.frame.width - 40, height: 45));
			label?.textAlignment = .Center;
			label?.backgroundColor = appBlueColor;
			label?.userInteractionEnabled = true;
//			label?.layer.cornerRadius = 23;
//			label?.layer.masksToBounds = true;

			switch section {
			case 0:
				label?.text = "\(TODAY)(\(entries.todayEntries.count))";
				label?.addGestureRecognizer(UITapGestureRecognizer(target: self,
					action: #selector(onTodayTap)));
				label?.userInteractionEnabled = true;

			case 1:
				label?.text = "\(THIS_WEEK)(\(entries.weekEntries.count)) "
				label?.addGestureRecognizer(UITapGestureRecognizer(target: self,
					action: #selector(onWeekTap)));

			case 2:
				label?.text = "\(OLDER)(\(entries.olderEntries.count)) ";
				label?.addGestureRecognizer(UITapGestureRecognizer(target: self,
					action: #selector(onOlderTap)));

			default: break;
			}
		default: return nil;
		}

		return label;
	}

	func onTodayTap() { showToday = !showToday; tableView.reloadData(); }
	func onWeekTap() { showWeek = !showWeek; tableView.reloadData(); }
	func onOlderTap() { showOlder = !showOlder; tableView.reloadData(); }

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

///
/// Three sections -- today's entries, this weeks entries, and older.
///
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

///
/// Make entries editable
///
	func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
		return true
	}

///
/// Enable deletion of entries
///
	func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle,
		forRowAtIndexPath indexPath: NSIndexPath) {
			if editingStyle == UITableViewCellEditingStyle.Delete {
				if let entry = entryForIndexPath(indexPath) {
					tableView.beginUpdates();
					DataManagerInstance().deleteEntryWithID(entry.entry_id)
					tableView.deleteRowsAtIndexPaths([indexPath],
						withRowAnimation: UITableViewRowAnimation.Left)
					refreshEntries();

					tableView.endUpdates();
				}
	} }

///
/// Get the entry based on the indexPath
///
	private func entryForIndexPath(indexPath: NSIndexPath) -> Entry? {
		let row = indexPath.row;
		switch indexPath.section {
		case 0: if 0 <= row && row < entries.todayEntries.count {
			return entries.todayEntries[indexPath.row];
			}
		case 1: if 0 <= row && row < entries.weekEntries.count {
			return entries.weekEntries[indexPath.row];
			}
		case 2: if 0 <= row && row < entries.olderEntries.count {
			return entries.olderEntries[indexPath.row];
			}
		default: break;
		}
		return nil;
	}
}
