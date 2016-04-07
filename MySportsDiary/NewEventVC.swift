//
//  FirstViewController.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 11/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import UIKit
import QuartzCore
import MobileCoreServices

class NewEventVC: UIViewController, UIPopoverPresentationControllerDelegate, UITextFieldDelegate, ImageCountDelegate {

    @IBOutlet weak var eventsPicker: UIPickerView!;
    @IBOutlet weak var descriptionTextField: UITextField!;
    @IBOutlet weak var imagesCountLabel: UILabel!;

    let popOverColor = UIColor(
        colorLiteralRed: 175 / 255,
        green: 210 / 255,
        blue: 234 / 255,
        alpha: 1);

    var eventsPickerDelegateDataSrc: EventsPickerDelegateDataSource?;

    override func viewDidLoad() {
        super.viewDidLoad();
        eventsPickerDelegateDataSrc = EventsPickerDelegateDataSource(parentVC: self)
        eventsPicker.dataSource = eventsPickerDelegateDataSrc;
        eventsPicker.delegate = eventsPickerDelegateDataSrc;
        let numComponents = eventsPickerDelegateDataSrc!.pickerView(eventsPicker,
            numberOfRowsInComponent: 0);
        eventsPicker.selectRow(numComponents / 2, inComponent: 0, animated: false);
    }

    func newSkillEntered(skillName: String) {
        descriptionTextField.text = "event...  " + skillName;
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.navigationBarHidden = true ;
        descriptionTextField.delegate = self;
        updateTempMediaCount();
        self.view.alpha = 1;
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated);
        if (navigationController?.topViewController != self) {
            self.navigationController?.navigationBarHidden = false;
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        self.view.alpha = 0.5;
        let controller = segue.destinationViewController;
        if segue.identifier == "photoSegue" {
            print("Photo segue");
        } else if segue.identifier == "videoSegue" {
            print("videoSegue");
        } else if segue.identifier == "audioSegue" {
            print("Audio segue");
        }
        /// segue configure the popover presentation
        controller.popoverPresentationController?.delegate = self;
        controller.preferredContentSize = CGSize(width: view.frame.width, height: view.frame.height);
        controller.popoverPresentationController?.sourceRect = (sender as! UIButton).bounds;
        controller.popoverPresentationController?.backgroundColor = popOverColor;
    }

    func popoverPresentationControllerDidDismissPopover(_: UIPopoverPresentationController) {
        self.view.alpha = 1;
    }

    func onImageCountChange() {
        updateTempMediaCount();
    }

    func updateTempMediaCount() {
        let imagesCount = DataManager.getManagerInstance().getImagesCount();
        imagesCountLabel.hidden = imagesCount == 0;
        imagesCountLabel.text = String(imagesCount);
    }

    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController)
        -> UIModalPresentationStyle {
            return .None;
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
}

protocol ImageCountDelegate {
    func onImageCountChange();
}
