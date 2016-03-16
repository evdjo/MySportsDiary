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
    
    private var ageChanged = false;
    private var genderChanged = false;
    
    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
    override func viewDidAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true);
        super.viewDidAppear(animated);
        if(loadAgeAndGender()) {
        nextButton.enabled = true;
        nextButton.alpha = 1.0;
        } else {
        nextButton.enabled = false;
        nextButton.alpha = 0.5;
        }
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidAppear(animated);
        saveAgeAndGender();
    }
    
    @IBAction func onAgeSliderMoved(sender: UISlider) {
        ageChanged = true;
        let intValue = Int(sender.value);
        ageTextField.text = String(intValue);
        if(genderChanged) {
        nextButton.enabled = true;
        nextButton.alpha = 1.0;
        }
    }

    @IBAction func onGenderSegmentChanged(sender: AnyObject) {
        genderChanged = true;
        if(ageChanged) {
        nextButton.enabled = true;
        nextButton.alpha = 1.0;
        }
    }
    
    private func loadAgeAndGender() -> Bool {
        var ageAndGenderWereLoaded = true;
        let gender = DataManager.getManagerInstance().getGender();
        if let gender = gender {
            let selectedIndex: Int = gender == .BOY ? 0 : 1;
            genderSegmentedControl.selectedSegmentIndex = selectedIndex;
        } else {
            print("gender was not set yet, not loading ");
            ageAndGenderWereLoaded = false;
        }
        
        let age = DataManager.getManagerInstance().getAge();
        if let age = age {
            ageTextField.text = String(age);
            ageSlider.value = Float(age);
        } else {
            print("age was not set yet, not loading ");
            ageAndGenderWereLoaded = false;
        }
        return ageAndGenderWereLoaded;
    }

    private func saveAgeAndGender() {
        if(ageChanged) {
            let age = Int(ageSlider.value);
            DataManager.getManagerInstance().saveAge(age);
        }
        if(genderChanged) {
            let gender: Gender = genderSegmentedControl.selectedSegmentIndex == 0 ? .BOY : .GIRL;
            DataManager.getManagerInstance().saveGender(gender);
        }
    }
    
    
    
    
    
    
    
    
    
    
    
}
