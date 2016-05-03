//
//  QuestionsViewController.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 11/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import UIKit

class QuestionsVC: UIViewController {
	/// the current page of the questionnaire
	private var page: Int = 0;
	
	/// The label showing which page we are currently at
	@IBOutlet weak var pageLabel: UILabel!
	
	/// The button on the bottom -- either 'Next' or 'Finish'
	@IBOutlet weak var bottomButton: UIButton!
	
	/// The labels to hold the text of the questions being asked currently
	@IBOutlet var questionLabels: [UILabel]!
	
	/// The custom views to indicate the slider's position
	@IBOutlet var theview: [CustomSliderOut]!
	
	/// The three sliders to accept the user input on the answers
	@IBOutlet var sliders: [UISlider]!
	
	/// The disagree labels
	@IBOutlet var disagree: [UILabel]!
	
	/// The agree labels
	@IBOutlet var agree: [UILabel]!
	
	override func viewDidLoad() {
		super.viewDidLoad();
		bottomButton.enabled = false;
		bottomButton.alpha = 0.5;
		setButton(bottomButton);
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated);
		let startIndex = page * 3;
		questionLabels[0].text = questions[startIndex];
		questionLabels[1].text = questions[startIndex + 1];
		questionLabels[2].text = questions[startIndex + 2];
		
		switch page {
		case 0, 1: bottomButton.setTitle(NEXT, forState: .Normal);
		default: bottomButton.setTitle(FINISH, forState: .Normal);
		}
		pageLabel.text = "\(page + 1) / 3";
		
		executeThis(afterDelayInSeconds: 0.5, {
			self.bottomButton.enabled = true;
			self.bottomButton.alpha = 1.0;
		});
		self.navigationController?
			.setNavigationBarHidden(false, animated: animated);
	}
///
/// When the slider is dragged,
/// normalize the slider's value to the custom view.
/// Then set the agree/disagree's transparency
///
	@IBAction func onSliderMoved(sender: UISlider) {
		if let index = sliders.indexOf(sender) {
			// normalize to fit the custom slider out view
			let norm = sender.value / sender.maximumValue * CustomSliderOut.maxValue
			theview[index].scale = norm
			
			// set the alphas
			agree[index].alpha = CGFloat(sender.value / 10);
			disagree[index].alpha = 1 - CGFloat(sender.value / 10);
		}
	}
///
/// On bottom press save the answers on the current page.
/// If on the final page ask if the users wants to finish the questionnaire
///
	@IBAction func onBottomButtonPressed(sender: AnyObject) {
        
		let state = DataManagerInstance().getAppState() ?? .Initial;
		
		DataManagerInstance().setAnswer(page * 3 + 0, answer: Int(sliders[0].value), forState: state);
		DataManagerInstance().setAnswer(page * 3 + 1, answer: Int(sliders[1].value), forState: state);
		DataManagerInstance().setAnswer(page * 3 + 2, answer: Int(sliders[2].value), forState: state);
		
		if page < 2 {
			let vc = UIStoryboard(name: "Main", bundle: nil)
				.instantiateViewControllerWithIdentifier("Questionnaire");
			(vc as! QuestionsVC).page = self.page + 1;
			self.navigationController?.pushViewController(vc, animated: true);
		} else {
			switch state {
			case .Initial: initialQuestionnaireFinished();
			case .Final: finalQuestionnaireFinished();
			default: return;
			}
		}
	}
	
///
/// After the inital questionnaire, set the mode to .Diary save the anwers,
/// enable the other two tab bars, and let the user create events
///
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
				DataManagerInstance().setAppState(.Diary);
				let dateNow = NSDate();
				let dateDiaryEnd = NSCalendar.currentCalendar()
					.dateByAddingUnit(
						Config.DiaryPeriodUnit,
						value: Config.DiaryPeriod,
						toDate: dateNow,
						options: [])!;
				
				DataManagerInstance().setDiaryEndDate(dateString(dateDiaryEnd));
				self.tabBarController!.tabBar.items![1].enabled = true;
				self.tabBarController!.tabBar.items![2].enabled = true;
				self.navigationController?
					.popToRootViewControllerAnimated(true);
		});
		
		let noAction = UIAlertAction(title: NO, style: .Cancel, handler: nil);
		
		controller.addAction(yesAction);
		controller.addAction(noAction);
		
		presentViewController(controller, animated: true, completion: nil)
	}
///
/// <<-- UNDER CONSTRUCTION -->>
/// <<-- UNDER CONSTRUCTION -->>
/// <<-- UNDER CONSTRUCTION -->>
///
	private func finalQuestionnaireFinished() {
		// SEND THE DATA HERE ...
		DataManagerInstance().purgeAllData();
		DataManagerInstance().setAppState(.Epilogue);
		
		self.navigationController?.popToRootViewControllerAnimated(true);
	}
}