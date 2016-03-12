//
//  QuestionnaireViewController.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 11/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import UIKit

class QuestionnaireViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
    
        if(!UserData.initialQuestionnareAnswered) {
            self.tabBarController!.tabBar.items![1].enabled = false;
            self.tabBarController!.tabBar.items![2].enabled = false;
            mainLabel.text = "Click the bellow button to answer the initial questionnaire."
            beginButton.hidden = false;
        } else {
            self.tabBarController!.tabBar.items![1].enabled = true;
            self.tabBarController!.tabBar.items![2].enabled = true;
            mainLabel.text = "You've answered the initial questionnaire. Now you can add new events. You will answer the inital questionnaire in ..."
            beginButton.hidden = true;
        }
        
        self.navigationController?.setNavigationBarHidden(true, animated: true);
        super.viewDidAppear(animated);

    }
    
    @IBOutlet weak var mainLabel: UILabel!
    
    @IBAction func onSurveyBegin(sender: AnyObject) {
        if(!UserData.initialQuestionnareAnswered) {
            self.performSegueWithIdentifier("AgeAndGenderSegue", sender: sender);
        } else {
            self.performSegueWithIdentifier("QuestionnaireSegue", sender: sender);
        }
    }
    
    @IBOutlet weak var beginButton: UIButton!
}
