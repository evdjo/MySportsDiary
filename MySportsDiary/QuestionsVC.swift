//
//  QuestionsViewController.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 11/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import UIKit

class QuestionsVC: UIViewController {

	let questions = [
		"I do well at any sports I play",
		"I am happy to be me.", "I get angry often",
		"I hit people if they start the fight",
		"I accept responsibility for my behaviour if I make a mistake",
		"I do very well in my school work",
		"I use my imagination to solve problems",
		"I want to help to make my community a better place to live",
		"I feel important in my community",
	]

	///
	/// Variables and outlets
	///
	private var page: Int = 0;
	@IBOutlet weak var pageLabel: UILabel!
	@IBOutlet weak var bottomButton: UIButton!
	@IBOutlet var questionLabels: [UILabel]!
	@IBOutlet var theview: [CustomSliderOut]!
	@IBOutlet var sliders: [UISlider]!

	@IBAction func onSliderMoved(sender: UISlider) {
		if let index = sliders.indexOf(sender) {
			let scale = Float(theview[index].scaleMultiplier) - 1;
			theview[index].selectedValue = Int(sender.value / 100 * scale)
		}
	}
	///
	/// App lifecycle methods
	///
	override func viewDidLoad() {
		super.viewDidLoad();
		theview.forEach({ slider in
			slider.color = UIColor.cyanColor();
		})
	}

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated);
		let startIndex = page * 3;
		questionLabels[0].text = questions[startIndex];
		questionLabels[1].text = questions[startIndex + 1];
		questionLabels[2].text = questions[startIndex + 2];
		switch page {
		case 0, 1:
			bottomButton.setTitle("Next", forState: .Normal);
		default:
			bottomButton.setTitle("Finish", forState: .Normal);
		}
		pageLabel.text = "\(page + 1) / 3";
	}

	@IBAction func onBottomButtonPressed(sender: AnyObject) {
		if page < 2 {
			let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Questionnaire");
			(vc as! QuestionsVC).page = self.page + 1;
			self.navigationController?.pushViewController(vc, animated: true);
		} else {
			initialQuestionnaireFinished();
		}
	}

//
// After the inital questionnaire, set the mode to .Diary save the anwers,
// enable the other two tab bars, and let the user create events
//
	private func initialQuestionnaireFinished() {
		// confirm
		let controller = UIAlertController(title: "Are you sure?",
			message: "Once finished, you cannot change your answers.",
			preferredStyle: .Alert)

		let yesAction = UIAlertAction(
			title: "Yes",
			style: .Default,
			handler: { action in
				// then save answers
				DataManagerInstance().setAppState(.Diary);
				let dateNow = NSDate();
				let dateAfter8Weeks = NSCalendar.currentCalendar()
					.dateByAddingUnit(.Minute, value: 10, toDate: dateNow, options: [])!;
                
				DataManagerInstance().setDiaryStart(dateString(dateAfter8Weeks));
				// enable second and third tabs, disable first, switch to second
				// self.tabBarController!.tabBar.items![0].enabled = false;
				self.tabBarController!.tabBar.items![1].enabled = true;
				self.tabBarController!.tabBar.items![2].enabled = true;
				// self.tabBarController!.selectedIndex = 1;
				self.navigationController?.popToRootViewControllerAnimated(true);
		});

		let noAction = UIAlertAction(
			title: "No",
			style: .Cancel,
			handler: nil);

		controller.addAction(yesAction)
		controller.addAction(noAction)
		presentViewController(controller, animated: true, completion: nil)
	}
}