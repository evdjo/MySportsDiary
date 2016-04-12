//
//  EntryViewerVC.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 12/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import UIKit

class SingleEntryViewerVC: UIViewController {

	@IBOutlet weak var skillLabel: UILabel!
	@IBOutlet weak var descriptionTextView: UITextView!

	var entry_id: Int64!;
	override func viewDidLoad() {
		super.viewDidLoad()
		if let entry = DataManagerInstance().getEntryForID(entry_id) {
			descriptionTextView.text = entry.description;
			skillLabel.text = entry.skill;
		}
	}
}
