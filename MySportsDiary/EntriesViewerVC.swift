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
		self.navigationController?.navigationBarHidden = true ;
		entries = DataManagerInstance().getEntries();
	}
	override func viewWillDisappear(animated: Bool) {
		super.viewWillDisappear(animated);
		self.navigationController?.navigationBarHidden = false;
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

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if let vc = segue.destinationViewController as? SingleEntryViewerVC,
			let cell = sender as? UITableViewCell,
			let index = tableView.indexPathForCell(cell) {
				vc.entry_id = Int64(index.row + 1);
		}
	}
}
