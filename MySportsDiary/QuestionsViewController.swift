//
//  QuestionsViewController.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 11/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import UIKit

class QuestionsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true);
        super.viewDidAppear(animated);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onFinishPress(sender: AnyObject) {
    // confirm
    
    // then save answers
    
    
    // start timer
    
    // enable second and third tabs, disable first, switch to second
    // self.tabBarController!.tabBar.items![0].enabled = false;
        self.tabBarController!.tabBar.items![1].enabled = true;
        self.tabBarController!.tabBar.items![2].enabled = true;
        //self.tabBarController!.selectedIndex = 1;
        self.navigationController?.popToRootViewControllerAnimated(true);
        UserData.initialQuestionnareAnswered = true;
    }

}
