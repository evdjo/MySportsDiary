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
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);

        
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
        
    }
    ///
    /// Enable the second and third tabs
    /// Hide the begin button in the first tab
    ///
    private func setForDiaryMode() {
        self.tabBarController?.tabBar.items![1].enabled = true;
        self.tabBarController?.tabBar.items![2].enabled = true;
        self.tabBarController?.selectedIndex = 1;
        mainLabel.text = "Thanks for having answered the initial questionnaire." +
        " You will answer the questionnaire again at the end." +
        " Now you can add new entries in the diary."
        beginButton.hidden = true;
    }
    
    ///
    /// Hide the second and third tabs
    /// Enable the begin button
    ///
    private func setForInitialMode() {
        self.tabBarController?.tabBar.items?[1].enabled = false;
        self.tabBarController?.tabBar.items?[2].enabled = false;
        mainLabel.text = "Click the bellow button to answer the initial questionnaire."
        beginButton.hidden = false;
    }
    
    ///
    /// Disable the second and third tabs again
    /// Enable the begin button
    ///
    private func setForFinalMode() {
        self.tabBarController?.tabBar.items?[1].enabled = false;
        self.tabBarController?.tabBar.items?[2].enabled = false;
        mainLabel.text = "Now you must answer the final questionnaire. Click below to begin."
        beginButton.hidden = false;
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
