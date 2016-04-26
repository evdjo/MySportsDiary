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
        
		if let entries = entries {
            
			entries.forEach({ entry in
                
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