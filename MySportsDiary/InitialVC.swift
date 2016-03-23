//
//  QuestionnaireViewController.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 11/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import UIKit

class InitialVC: UIViewController {
    
    ///
    /// Hide back button
    /// Set the tab bar buttons enabledness
    /// See which mode we're at currently
    ///
    override func viewDidAppear(animated: Bool) {
        
        let appState = DataManager.getManagerInstance().getAppState() ?? .Initial
        switch(appState) {
        case(.Diary) :
            setForDiaryMode();
        case(.Initial):
            setForInitialMode() ;
        case(.Final):
            setForFinalMode();
        }
        /// hide the bar above, since there is no back screen to move to
        self.navigationController?.setNavigationBarHidden(true, animated: true);
        super.viewDidAppear(animated);
        
    }
    
    private func setForDiaryMode() {
        self.tabBarController!.tabBar.items![1].enabled = true;
        self.tabBarController!.tabBar.items![2].enabled = true;
        mainLabel.text = "You've answered the initial questionnaire." +
        " Now you can add new events. You will answer the inital questionnaire in ..."
        beginButton.hidden = true;
    }
    
    private func setForInitialMode() {
        self.tabBarController!.tabBar.items![1].enabled = false;
        self.tabBarController!.tabBar.items![2].enabled = false;
        mainLabel.text = "Click the bellow button to answer the initial questionnaire."
        beginButton.hidden = false;
    }
    
    private func setForFinalMode() {
        // TODO
    }
    @IBOutlet weak var mainLabel: UILabel!
    
    
    ///
    /// See if it is the first survey or final survey...
    ///
    @IBAction func onSurveyBegin(sender: AnyObject) {
        let appState = DataManager.getManagerInstance().getAppState() ?? .Initial;
        if(appState == .Initial) {
            self.performSegueWithIdentifier("AgeAndGenderSegue", sender: sender);
        } else {
            self.performSegueWithIdentifier("QuestionnaireSegue", sender: sender);
        }
    }
    @IBOutlet weak var beginButton: UIButton!
}
