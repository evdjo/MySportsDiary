//
//  FirstViewController.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 11/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import UIKit

class NewEventVC: UIViewController {

    @IBOutlet weak var eventsPicker: UIPickerView!
    let eventsPickerDelegateDataSrc = EventsPickerDelegateDataSource();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventsPicker.dataSource = eventsPickerDelegateDataSrc;
        eventsPicker.delegate = eventsPickerDelegateDataSrc;

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

