//
//  QuestionsViewController.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 11/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import UIKit

class QuestionsVC: UIViewController {
	///
	/// Variables and outlets
	//
	private var page: Int = 0;
	@IBOutlet weak var pageLabel: UILabel!
	@IBOutlet weak var bottomButton: UIButton!

	@IBOutlet var questionLabels: [UILabel]!
	@IBOutlet var theview: [CustomSliderOut]!
	@IBOutlet var sliders: [UISlider]!

	@IBOutlet var sliderValueLabel: [UILabel]!

	@IBOutlet var disagree: [UILabel]!
	@IBOutlet var agree: [UILabel]!

	@IBAction func onSliderMoved(sender: UISlider) {
		if let index = sliders.indexOf(sender) {
			// scale to the max of the selected value
			let scale = sender.value / sender.maximumValue * CustomSliderOut.maxValue

			theview[index].scale = scale

			agree[index].alpha = CGFloat(sender.value / 10);
			disagree[index].alpha = 1 - CGFloat(sender.value / 10);
			sliderValueLabel[index].text = String(Int(sender.value));
		}
	}
///
/// App lifecycle methods
//
	override func viewDidLoad() {
		super.viewDidLoad();
		bottomButton.enabled = false;
	}

	override func viewWillAppear(animated: Bool) {
		bottomButton.enabled = true;
		super.viewWillAppear(animated);
		let startIndex = page * 3;
		questionLabels[0].text = questions[startIndex];
		questionLabels[1].text = questions[startIndex + 1];
		questionLabels[2].text = questions[startIndex + 2];
		switch page {
		case 0, 1:
			bottomButton.setTitle(NEXT, forState: .Normal);
		default:
			bottomButton.setTitle(FINISH, forState: .Normal);
		}
		pageLabel.text = "\(page + 1) / 3";
	}

	@IBAction func onBottomButtonPressed(sender: AnyObject) {
		DataManagerInstance().setAnswer(page * 3 + 0, answer: Int(sliders[0].value));
		DataManagerInstance().setAnswer(page * 3 + 1, answer: Int(sliders[1].value));
		DataManagerInstance().setAnswer(page * 3 + 2, answer: Int(sliders[2].value));
		if page < 2 {
			let vc = UIStoryboard(name: "Main", bundle: nil)
				.instantiateViewControllerWithIdentifier("Questionnaire");
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
		let controller = UIAlertController(
			title: ARE_YOU_SURE,
			message: FINISH_QUESTIONNAIRE_CONFIRM,
			preferredStyle: .Alert)

		let yesAction = UIAlertAction(
			title: YES,
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
			title: NO,
			style: .Cancel,
			handler: nil);

		controller.addAction(yesAction)
		controller.addAction(noAction)
		presentViewController(controller, animated: true, completion: nil)
	}
}