//
//  AllEntriesViewerVC.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 11/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import UIKit
import QuartzCore

class AllEntriesViewerVC: UIViewController, UITableViewDelegate,
UITableViewDataSource, UIGestureRecognizerDelegate {
    
/// The table view shows all the entries added so far.
    @IBOutlet weak var tableView: UITableView!;
	
/// The label to show when the shown entries count is 0
    @IBOutlet weak var noEntriesLabel: UILabel!;
	
/// The segmented control to switch between Today, Week and Older
    @IBOutlet weak var todayWeekOlderSegControl: UISegmentedControl!;
	
/// The entry cell identifier
	private let eventCellID = "eventCellID";
	
/// The list of entries
	private var entries: EntriesByDate?;
	
/// Which entries are shown
	private var shownEntries: ShownEntries = .Today;
	
/// Flag to indicate if a new entry was added
	var newEntryAdded = false;
	
	override func viewDidLoad() {
		super.viewDidLoad();
		setSegmentedControl(todayWeekOlderSegControl);
	}
	
///
/// Before we appear, reload the entries
/// If a new entry was added, move to "Today" segment
/// Change shown entries to .Today
/// and finally hide the table view, and show the label if no entries
///
	override func viewWillAppear(animated: Bool) -> Void {
		super.viewWillAppear(animated);
		navigationController?.navigationBarHidden = true;
		entries = DataManagerInstance().getEntriesByDate();
		if newEntryAdded {
			todayWeekOlderSegControl.selectedSegmentIndex = 0;
            shownEntries = .Today;
		}
		hideTableIfNoEntries();
	}
    
///
/// After we appear, animate the table reload if there was new entry added
///
	override func viewDidAppear(animated: Bool) -> Void {
		super.viewDidAppear(animated);
		if newEntryAdded {
			newEntryAdded = false;
			
			// scroll to the bottom of the table, and highligh the last cell
			UIView.transitionWithView(tableView,
				duration: 0.275,
				options: .TransitionCrossDissolve,
				animations: {
					self.tableView.reloadData();
					self.tableView.scrollToRowAtIndexPath(self.lastIndex,
						atScrollPosition: .Bottom,
						animated: false);
					self.lastCell?.highlighted = true;
				},
				completion: nil);
			
			// undo the highlight after 1 second
            executeThis(afterDelayInSeconds: 0.5, {
                self.lastCell?.highlighted = false;
            })
			 
		}
	}
	
///
/// The empty view to serve as a margin
///
	func tableView(
		tableView: UITableView,
		viewForHeaderInSection section: Int
	) -> UIView?
	{
		let header = UIView();
		header.backgroundColor = UIColor.clearColor();
		return header;
	}
    
///
/// Margin between cells
///
	func tableView(
		tableView: UITableView,
		heightForHeaderInSection section: Int
	) -> CGFloat
	{
		return 4.0;
	}
    
///
/// Number of 1 cell sections, that is the number of currently viewed entries
///
	func numberOfSectionsInTableView(
		tableView: UITableView
	) -> Int
	{
		guard nil != entries else { return 0; }
		switch shownEntries {
		case .Today: return entries?.todayEntries.count ?? 0;
		case .Week: return entries?.weekEntries.count ?? 0;
		case .Older: return entries?.olderEntries.count ?? 0;
		}
	}
    
///
/// The count of table cells of entries for today, the week or older
///
	func tableView(
		tableView: UITableView, numberOfRowsInSection section: Int
	) -> Int
	{
		return 1;
	}
	
///
/// The cell of each entry.
/// Simply fetch the entry's skill and date.
/// That's what we show for now.
///
	func tableView(
		tableView: UITableView, cellForRowAtIndexPath
		indexPath: NSIndexPath
	) -> UITableViewCell
	{
		let cell = tableView.dequeueReusableCellWithIdentifier(
			eventCellID,
			forIndexPath: indexPath);
		
		if let entry = entryForIndexPath(indexPath) {
			if let date = stringDate(entry.date_time) {
				cell.detailTextLabel?.text = screenDateString(date);
			}
			cell.textLabel?.text = entry.skill;
			cell.layer.borderWidth = 1.0
			cell.textLabel?.textColor = Config.cellTextcolor;
			cell.layer.borderColor = Config.borderColor;
			cell.backgroundColor = Config.cellBackgroundColor;
			cell.layer.cornerRadius = Config.buttonsRadius;
			
			let highlighted = UIView();
			highlighted.backgroundColor = Config.cellHighlightedColor;
			cell.selectedBackgroundView = highlighted;
		}
		return cell;
	}
	
///
/// When we press a entry cell, we set the entry of the SingleEntryViewerVC
/// We also set it's type of .Existing.
///
	override func prepareForSegue(
		segue: UIStoryboardSegue,
		sender: AnyObject?
	) -> Void
	{
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
	func tableView(
		tableView: UITableView, canEditRowAtIndexPath
		indexPath: NSIndexPath
	) -> Bool
	{
		return true;
	}
	
///
/// Enable deletion of entries
////
	func tableView(
		tableView: UITableView,
		commitEditingStyle editingStyle: UITableViewCellEditingStyle,
		forRowAtIndexPath indexPath: NSIndexPath
	) -> Void
	{
		if editingStyle == UITableViewCellEditingStyle.Delete {
			if let entry = entryForIndexPath(indexPath) {
				DataManagerInstance().deleteEntryWithID(entry.entry_id);
				self.entries = DataManagerInstance().getEntriesByDate();
				tableView.beginUpdates();
				tableView.deleteSections(
					NSIndexSet(index: indexPath.section),
					withRowAnimation: .Automatic);
				
				tableView.endUpdates();
				hideTableIfNoEntries();
			}
		}
	}
	
///
/// When the user changes between Today, Week and Older
///
	@IBAction func onShownEntriesPressed(sender: UISegmentedControl) {
		let selected = sender.selectedSegmentIndex;
		guard 0 <= selected && selected <= 2 else { return }
		switch selected {
		case 0: shownEntries = .Today
		case 1: shownEntries = .Week
		case 2: shownEntries = .Older
		default: break;
		}
		tableView.reloadData();
		hideTableIfNoEntries();
	}
	
///
/// Get the entry based on the indexPath
///
	private func entryForIndexPath(indexPath: NSIndexPath) -> Entry? {
		let index = indexPath.section;
		if let entries = entries {
			switch shownEntries {
			case .Today: if 0 <= index && index < entries.todayEntries.count {
				return entries.todayEntries[index];
				}
			case .Week: if 0 <= index && index < entries.weekEntries.count {
				return entries.weekEntries[index];
				}
			case .Older: if 0 <= index && index < entries.olderEntries.count {
				return entries.olderEntries[index];
				}
			}
		}
		return nil;
	}
	
///
/// Check if the table has to be hidden, and hide it if needed
///
	private func hideTableIfNoEntries() {
		let hideTable = entriesCount == 0;
		tableView.hidden = hideTable;
		noEntriesLabel.hidden = !hideTable;
	}
	
///
/// Count of currently visible entries in the table
///
	private var entriesCount: Int {
		get {
			let count: Int;
			switch shownEntries {
			case .Today: count = entries?.todayEntries.count ?? 0;
			case .Week: count = entries?.weekEntries.count ?? 0
			case .Older: count = entries?.olderEntries.count ?? 0
			}
			return count;
		}
	};
	
///
/// Index of the last cell in the table
///
	private var lastIndex: NSIndexPath {
		return NSIndexPath(forRow: 0, inSection: tableView.numberOfSections - 1)
	}
///
/// The last cell in the tableView
///
	private var lastCell: UITableViewCell? {
		return tableView?.cellForRowAtIndexPath(lastIndex);
	}
}
