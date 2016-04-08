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

class NewEventVC: UIViewController, UIPopoverPresentationControllerDelegate, UITextViewDelegate, MediaCountDelegate {

    @IBOutlet weak var audioCountLabel: UILabel!
    @IBOutlet weak var videoCountLabel: UILabel!
    @IBOutlet weak var imagesCountLabel: UILabel!;
    @IBOutlet weak var descriptionTextArea: UITextView!

    var skill: String = "";
    let blue = UIColor(colorLiteralRed: 175 / 255, green: 210 / 255, blue: 234 / 255, alpha: 1);

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        descriptionTextArea.delegate = self;
        descriptionTextArea.text = "Rugby has helped demonstrate \(skill) because, ";
        updateImagesCount();
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

        if segue.identifier == "photoSegue" || segue.identifier == "videoSegue" {
            controller.preferredContentSize = CGSize(width: view.frame.width, height: view.frame.height);
        } else if segue.identifier == "audioSegue" {
            controller.preferredContentSize = CGSize(width: view.frame.width, height: 60);
        }

        if let controller = controller as? MediaContainer {
            controller.mediaCountDelegate = self;
        }

        controller.popoverPresentationController?.delegate = self;
        controller.popoverPresentationController?.sourceRect = (sender as! UIButton).bounds;
        controller.popoverPresentationController?.backgroundColor = blue;
    }

    func popoverPresentationControllerDidDismissPopover(_: UIPopoverPresentationController) {
        self.view.alpha = 1;
    }

    func onCountChange(sender: UIViewController) {
        if sender is ImagesPopoverVC {
            updateImagesCount();
        } else if sender is VideoPopoverVC {
            updateVideoCount();
        } else if sender is AudioRecorderVC {
            updateAudioCount();
        }
    }
///
/// Hide the keyboard on done pressed
///
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange,
        replacementText text: String) -> Bool {
            if text == "\n" {
                textView.resignFirstResponder();
                return false;
            }
            return true;
    }

    func updateImagesCount() {
        let imagesCount = DataManager.getManagerInstance().getImagesCount();
        if imagesCount > 0 {
            imagesCountLabel.text = String(imagesCount);
            imagesCountLabel.hidden = false;
        } else {
            imagesCountLabel.hidden = true;
        }
    }

    func updateVideoCount() {
        let imagesCount = DataManager.getManagerInstance().getImagesCount();
        videoCountLabel.text = String(imagesCount);
    }

    func updateAudioCount() {
        let imagesCount = DataManager.getManagerInstance().getImagesCount();
        audioCountLabel.text = String(imagesCount);
    }

    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController)
        -> UIModalPresentationStyle {
            return .None;
    }
}

protocol MediaCountDelegate {
    func onCountChange(sender: UIViewController);
}

protocol MediaContainer: class {
    var mediaCountDelegate: MediaCountDelegate? { get set }
}
