//
//  QuestionsViewController.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 11/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import UIKit

class QuestionsViewController: UIViewController {
    
    
    @IBOutlet var lickertSegmentedControls: [UISegmentedControl]!
    
    private var page: Int?;
    public var event_id = 0;
    
    
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
//        print("load");
//        print(page);
    }
    
    
    
    
    override func viewDidAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true);
        super.viewDidAppear(animated);
//        print("appear");
//        print(page);
    }
    
    @IBOutlet var questions: [UISegmentedControl]!
    
    @IBAction func onFinishPress(sender: AnyObject) {
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
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated);
        
 

    }
}

//    override func willMoveToParentViewController(parent: UIViewController?) {
//        page--;
//        print("current page is  --\(page)");
//
//    }
//

