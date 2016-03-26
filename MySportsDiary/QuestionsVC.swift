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
    ///
    private var page: Int = 0;
    @IBOutlet var answersSegControl: [UISegmentedControl]!
    @IBOutlet var nextOrFinishButton: UIButton!
    
    ///
    /// App lifecycle methods
    ///
    
    override func viewDidLoad() {
        /// load the page of questionnaire, based on the story board identifier
        if let id = self.restorationIdentifier {
            switch(id) {
            case("QuestionsPartA") : page = 1;
            case("QuestionsPartB") : page = 2;
            case("QuestionsPartC") : page = 3;
            default : fatalError("Uknown identifier, cannot setup page property!");
            }
        }
        
        answersSegControl[0].accessibilityIdentifier = "firstQuestion";
        answersSegControl[1].accessibilityIdentifier = "secondQuestion";
        answersSegControl[2].accessibilityIdentifier = "thirdQuestion";
        
        
        let app = UIApplication.sharedApplication()
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(applicationWillResignActive(_:)),
                                                         name: UIApplicationWillResignActiveNotification,
                                                         object: app)
        super.viewDidLoad();
    }
    
    override func viewDidAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true);
        /// load any answers
        loadAnswers()
        /// if all questions answered, the enable the next button
        enableButtonIfAllQuestionsAnswered();
        super.viewDidAppear(animated);
    }
    
    override func viewDidDisappear(animated: Bool) {
        saveAnswers();
    }
    
    func applicationWillResignActive(notification: NSNotification) {
        print("applicationWillResignActive was called");
        saveAnswers();
    }
    
    ///
    /// Handle the events that occurr in the questionnaire view
    ///
    
    //
    // When when we finish the inital and final questionnaire.
    //
    @IBAction func onFinishPress(sender: AnyObject) {
        let appState = DataManager.getManagerInstance().getAppState() ?? .Initial
        switch(appState) {
        case(.Initial) :
            initialQuestionnaireFinished();
        case(.Final) :
            finalQuestionnaireFinished();
        case(.Diary) :
            fatalError("TODO");
        }
    }
    
    //
    // Persist the current answers, in case the user goes back twice, and then goes forward.
    //
    @IBAction func onNextPress(sender: UIButton) {
        saveAnswers();
    }
    
    //
    // After the inital questionnaire, set the mode to .Diary save the anwers,
    // enable the other two tab bars, and let the user create events
    //
    private func initialQuestionnaireFinished() {
        // confirm
        let controller = UIAlertController(
            title: "Are you sure?",
            message: "Once finished, you cannot change your answers.",
            preferredStyle: .ActionSheet)
        
        let yesAction = UIAlertAction(
            title: "Yes",
            style: .Default,
            handler: { action in
                // then save answers
                DataManager.getManagerInstance().setAppState(.Diary);
                DataManager.getManagerInstance().saveCurrentAnswersInitial();
                
                // enable second and third tabs, disable first, switch to second
                // self.tabBarController!.tabBar.items![0].enabled = false;
                self.tabBarController!.tabBar.items![1].enabled = true;
                self.tabBarController!.tabBar.items![2].enabled = true;
                //self.tabBarController!.selectedIndex = 1;
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
    
    //
    // Send all data to the server and delete local content
    //
    func finalQuestionnaireFinished() {
        //TODO
    }
    
    
    //
    // When the user selects any answer, see if we can enable the "Next" button
    //
    @IBAction func onAnswerSelected(sender: UISegmentedControl) {
        enableButtonIfAllQuestionsAnswered();
    }
    
    //
    // Check all three segmented controls in the current questionnire page.
    // If all of them are selected, we enable the next button.
    //
    private func enableButtonIfAllQuestionsAnswered() {
        let currentQuestionsAnswered =
            (answersSegControl[0].selectedSegmentIndex != -1) &&
                (answersSegControl[1].selectedSegmentIndex != -1) &&
                (answersSegControl[2].selectedSegmentIndex != -1);
        
        
        if(currentQuestionsAnswered) {
            nextOrFinishButton.enabled = true;
            nextOrFinishButton.alpha = 1.0;
        } else {
            nextOrFinishButton.enabled = false;
            nextOrFinishButton.alpha = 0.5;
        }
    }
    
    ///
    /// Save answers
    ///
    private func saveAnswers() {
        let manager = DataManager.getManagerInstance();
        for i in 0...2 {
            let index = answersSegControl[i].selectedSegmentIndex
            if(index != -1) {
                manager.saveAnswer(questionID(page,index: i),answer: index);
            }
        }
    }
    
    ///
    /// Load the answers (if any)
    ///
    private func loadAnswers() {
        let manager = DataManager.getManagerInstance();
        for i in 0...2 {
            if let answer = manager.getAnswer(questionID(page,index: i)) {
                answersSegControl[i].selectedSegmentIndex = answer;
            }
        }
    }
    
    ///
    /// Locate the question id based on the current age, and the index of the segmented control
    ///
    private func questionID(page: Int, index : Int) ->Int {
        return page * 3 - 3 + index;
    }
}