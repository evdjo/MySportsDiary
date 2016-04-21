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
	var entries: [Entry]? = nil;

/// On appear load all the entries from the db
/// Then show them on the tableview.
/// The explicit reloadData is called, because if the view controller
/// appears from navigation, let's say, the table won't reload itself.
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated);
		self.navigationController?.navigationBarHidden = true ;
		entries = DataManagerInstance().getEntries();

		tableView.reloadData();
	}
/// The count of table cells, is the number of entries + 1.
/// The last table cell, is the add new entry button.
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return (entries?.count ?? 0);
	}
/// When we select the last cell, redirect the user to the second tab bar.
//	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//
//		if let entries = entries where entries.count > 0 && indexPath.row < entries.count {
//			return;
//		} else {
//			self.tabBarController?.selectedIndex = 2;
//			if let vc = self.tabBarController?.viewControllers?[2] as? UINavigationController {
//				vc.popToRootViewControllerAnimated(false);
//			}
//		}
//	}
/// The cell of each entry.
/// Simply fetch the entry's skill and date.
/// That's what we show for now.
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		// if let entries = entries where entries.count > indexPath.row {
		let cell = tableView.dequeueReusableCellWithIdentifier(eventCellContentIdentifier, forIndexPath: indexPath)
		let entryIndex = indexPath.row ;
		if 0 <= entryIndex && entries!.count > entryIndex {
			let entry = entries![entryIndex]
			let date = stringDate(entry.date_time);
			cell.detailTextLabel?.text = screenDateString(date);
			cell.textLabel?.text = entry.skill
			if (entryIndex == entries!.count - 1) {
				cell.backgroundColor = appBlueColor;

				let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 1 * Int64(NSEC_PER_SEC))
				dispatch_after(time, dispatch_get_main_queue()) {
					cell.backgroundColor = UIColor.whiteColor();
				}
			}
		}
		return cell;
//		} else {
//			return tableView.dequeueReusableCellWithIdentifier(newEntryCellIdentifier, forIndexPath: indexPath);
//		}
	}
/// Just one section. The default value is also 1,
/// but have it here ready to change if we need.
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1;
	}
/// When we press a entry cell, we set the entry of the SingleEntryViewerVC
/// We also set it's type of .Existing.
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
