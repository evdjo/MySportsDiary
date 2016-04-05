//
//  FirstViewController.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 11/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import UIKit
import QuartzCore

class NewEventVC: UIViewController, UIPopoverPresentationControllerDelegate, UITextFieldDelegate, ImageCountDelegate {

    @IBOutlet weak var eventsPicker: UIPickerView!;
    @IBOutlet weak var descriptionTextField: UITextField!;
    @IBOutlet weak var imagesCountLabel: UILabel!;

    let eventsPickerDelegateDataSrc = EventsPickerDelegateDataSource();

    override func viewDidLoad() {
        super.viewDidLoad();
        eventsPicker.dataSource = eventsPickerDelegateDataSrc;
        eventsPicker.delegate = eventsPickerDelegateDataSrc;
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.navigationBarHidden = true ;
        descriptionTextField.delegate = self;
        updateTempMediaCount();
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated);
        if (navigationController?.topViewController != self) {
            self.navigationController?.navigationBarHidden = false;
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // segue for the popover configuration window
        if segue.identifier == "photoSegue" {
            let controller = segue.destinationViewController;
            controller.popoverPresentationController?.delegate = self;
            controller.preferredContentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height);
            controller.popoverPresentationController?.sourceRect = (sender as! UIButton).bounds;
            controller.popoverPresentationController?.backgroundColor = UIColor(colorLiteralRed: 175 / 255, green: 210 / 255, blue: 234 / 255, alpha: 1);
            if let imagePickerVC = controller as? ImagePickerPopoverVC {
                imagePickerVC.imageCountDelegate = self;
            }
        }
    }

    func onImageCountChange() {
        updateTempMediaCount();
    }

    func updateTempMediaCount() {
        let imagesCount = DataManager.getManagerInstance().getImagesCount();
        imagesCountLabel.hidden = imagesCount == 0;
        imagesCountLabel.text = String(imagesCount);
    }

    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
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
