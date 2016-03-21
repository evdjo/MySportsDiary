//
//  QuestionsViewController.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 11/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import UIKit

class QuestionsVC: UIViewController {
    
    // MARK:-
    // MARK: Variables and outlets
    
    internal var type: QuestionnaireType?;
    private var page: Int = 0;
    
    @IBOutlet var answersSegControl: [UISegmentedControl]!
    @IBOutlet var nextOrFinishButtons: [UIButton]!
    
    
    
    // MARK: App lifecycle methods
    
    override func viewDidLoad() {
        if let id = self.restorationIdentifier {
            switch(id) {
            case("QuestionsPartA") : page = 1;
            case("QuestionsPartB") : page = 2;
            case("QuestionsPartC") : page = 3;
            default : fatalError("Uknown identifier, cennot setup page property!");
            }
        }
        super.viewDidLoad();
    }
    
    override func viewDidAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true);
        loadAnswers()
        checkIfQuestionsAnswered();
        super.viewDidAppear(animated);
        
    }
    
    
    override func viewDidDisappear(animated: Bool) {
        saveAnswers();
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? QuestionsVC {
            vc.type = type;
        }
    }
    
    
    
    
    // MARK: Handle the events that occurr in the questionnaire view
    
    @IBAction func onFinishPress(sender: AnyObject) {
        
        if let type = type {
            
            switch(type) {
            case(.INITIAL) :
                initialQuestionnaireFinished(); return;
            case(.FINAL) : break
                // final questionnaire
            case(.NORMAL) : break
                // another event
                
            }
            
        }
    }
    @IBAction func onNextPress(sender: UIButton) {
        saveAnswers();
    }
    
    private func questionID(page: Int, index : Int) ->Int {
        return page * 3 - 3 + index;
    }
    
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
                DataManager.getManagerInstance().initialQuestionnareAnswered();
                
                // start timer
                
                // enable second and third tabs, disable first, switch to second
                // self.tabBarController!.tabBar.items![0].enabled = false;
                self.tabBarController!.tabBar.items![1].enabled = true;
                self.tabBarController!.tabBar.items![2].enabled = true;
                //self.tabBarController!.selectedIndex = 1;
                UserData.initialQuestionnareAnswered = true;
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
    
    
    @IBAction func onAnswerSelected(sender: UISegmentedControl) {
        checkIfQuestionsAnswered();
    }
    
    private func checkIfQuestionsAnswered() {
        let currentQuestionsAnswered =
        (answersSegControl[0].selectedSegmentIndex != -1) &&
            (answersSegControl[1].selectedSegmentIndex != -1) &&
            (answersSegControl[2].selectedSegmentIndex != -1);
        
        let button = nextOrFinishButtons[0];
        if(currentQuestionsAnswered) {
            button.enabled = true;
            button.alpha = 1.0;
        } else {
            button.enabled = false;
            button.alpha = 0.5;
        }
    }
    
    private func saveAnswers() {
        let manager = DataManager.getManagerInstance();
        for i in 0...2 {
            let index = answersSegControl[i].selectedSegmentIndex
            if(index != -1) {
                manager.saveAnswer(questionID(page,index: i),answer: index);
            }
        }
    }
    
    private func loadAnswers() {
        let manager = DataManager.getManagerInstance();
        for i in 0...2 {
            if let answer = manager.getAnswer(questionID(page,index: i)) {
                answersSegControl[i].selectedSegmentIndex = answer;
            }
        }
    }
}