//
//  AgeAndGenderViewController.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 11/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import UIKit

class AgeAndGenderViewController: UIViewController {
    
    
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var ageSlider: UISlider!
    @IBOutlet weak var ageTextField: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    private var ageIsSet = false;
    private var genderIsSet = false;
    
    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
    override func viewDidAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true);
        super.viewDidAppear(animated);
        loadAge(); loadGender();
        if(ageIsSet && genderIsSet) {
            nextButton.enabled = true;
            nextButton.alpha = 1.0;
        } else {
            nextButton.enabled = false;
            nextButton.alpha = 0.5;
        }
    }
    
    @IBAction func onAgeSliderMoved(sender: UISlider) {
        ageTextField.text = String(Int(ageSlider.value));
    }
    @IBAction func onAgeSliderValueChanged(sender: UISlider) {
        DataManager.getManagerInstance().saveAge(Int(ageSlider.value));
        if(genderIsSet) {
            nextButton.enabled = true;
            nextButton.alpha = 1.0;
        }
    }
    
    @IBAction func onGenderSegmentChanged(sender: AnyObject) {
        let gender: Gender = genderSegmentedControl.selectedSegmentIndex == 0 ? .BOY : .GIRL;
        DataManager.getManagerInstance().saveGender(gender);
        genderIsSet = true;
        if(ageIsSet) {
            nextButton.enabled = true;
            nextButton.alpha = 1.0;
        }
    }
    
    private func loadGender(){
        let gender = DataManager.getManagerInstance().getGender();
        if let gender = gender {
            let selectedIndex: Int = gender == .BOY ? 0 : 1;
            genderSegmentedControl.selectedSegmentIndex = selectedIndex;
            genderIsSet = true ;
        } else {print("gender was not set yet, not loading "); genderIsSet=false;}
    }
    private func loadAge(){
        let age = DataManager.getManagerInstance().getAge();
        if let age = age {
            ageTextField.text = String(age);
            ageSlider.value = Float(age);
            ageIsSet = true;
        } else {print("age was not set yet, not loading ");ageIsSet=false;}
        
    }
    
}
