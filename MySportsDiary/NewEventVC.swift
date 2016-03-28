//
//  FirstViewController.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 11/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import UIKit

class NewEventVC: UIViewController, UIPopoverPresentationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var eventsPicker: UIPickerView!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    
    let eventsPickerDelegateDataSrc: EventsPickerDelegateDataSource = EventsPickerDelegateDataSource();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventsPicker.dataSource = eventsPickerDelegateDataSrc;
        eventsPicker.delegate = eventsPickerDelegateDataSrc;
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true ;
        descriptionTextField.delegate = self;
        super.viewWillAppear(true);
    }
    
    override func viewWillDisappear(animated: Bool) {
        if(navigationController?.topViewController != self) {
            self.navigationController?.navigationBarHidden = false;
        }
        super.viewWillDisappear(true);
    }
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //segue for the popover configuration window
        if segue.identifier == "id" {
            let controller = segue.destinationViewController;
            controller.popoverPresentationController!.delegate = self
            controller.preferredContentSize = CGSize(width: 240, height: self.view.frame.height / 2)
            controller.popoverPresentationController!.sourceRect = (sender as! UIButton).bounds
            
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
    
    
}

