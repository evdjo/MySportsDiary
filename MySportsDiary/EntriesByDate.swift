//
//  EntriesByDate.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 22/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation

class EntriesByDate {
	lazy var todayEntries: [Entry] = [Entry]();
	lazy var weekEntries: [Entry] = [Entry]();
	lazy var monthEntries: [Entry] = [Entry]();
	
	init(entries: [Entry]?) {
		let timeNow = NSDate();
		
		var entriesCopy = entries;
		
		entriesCopy?.sortInPlace({ (entry1, entry2) -> Bool in
			if let date1 = stringDate(entry1.date_time),
				let date2 = stringDate(entry2.date_time) {
                return date1.compare(date2) == .OrderedDescending;
			}
			return false;
		})
        
        
        
		if let entriesCopy = entriesCopy {
			entriesCopy.forEach({ entry in
				
				if let date = stringDate(entry.date_time) {
					if NSCalendar.currentCalendar().isDateInToday(date) {
						todayEntries.append(entry);
						weekEntries.append(entry);
						monthEntries.append(entry);
					} else if datesAreWithinWeek(date, timeNow) {
						weekEntries.append(entry);
						monthEntries.append(entry);
					} else {
						monthEntries.append(entry);
					}
				}
			})
		}

	}
}