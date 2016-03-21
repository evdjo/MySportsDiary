//
//  QuestionsViewController.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 11/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import UIKit

class QuestionsVC: UIViewController {
    
    public var type: QuestionnaireType?;
    private var page: Int?;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        if let id = self.restorationIdentifier {
            switch(id) {
            case("QuestionsPartA") : page = 1;
            case("QuestionsPartB") : page = 2;
            case("QuestionsPartC") : page = 3;
            default : break;
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true);
        super.viewDidAppear(animated);
    }
    
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? QuestionsVC {
        vc.type = type;
        }
    }
}


