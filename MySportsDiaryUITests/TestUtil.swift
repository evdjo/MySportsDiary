//
//  TestUtil.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 03/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import XCTest

struct Accessibility {
    static let MainLabel = "MainLabel";
    static let BeginButton = "BeginButton";
    static let AgeQuestionLabel = "AgeQuestionLabel";
    static let AgeSlider = "AgeSlider";
    static let AgeLabel = "AgeLabel";
    static let GenderQuestionLabel = "GenderQuestionLabel";
    static let GenderSegmentedControl = "GenderSegmentedControl";
    static let NextButton = "NextButton";
    static let Questions = ["QuestionOne", "QuestionTwo", "QuestionThree"]
    static let QuestionsLabels = ["QuestionOneLabel", "QuestionTwoLabel", "QuestionThreeLabel"]
}

let maxAge: CGFloat = 65.0;
let girl = "Girl";
let boy = "Boy";
let app: XCUIApplication! = XCUIApplication();
let beginButton = app.buttons["Begin"];
let nextButton = app.buttons["Next"];
let finishButton = app.buttons["Finish"];
let tabBarQuestionnaire = app.tabBars.buttons["Questionnaire"];
let tabDiary = app.tabBars.buttons["New Entry"];
let tabBarSecond = app.tabBars.buttons["Second"];
let backButtonAgeGender = app.navigationBars["MySportsDiary.AgeGenderVC"].childrenMatchingType(.Button).matchingIdentifier("Back").elementBoundByIndex(0);
let backButtonQuestions = app.navigationBars["MySportsDiary.QuestionsVC"].childrenMatchingType(.Button).matchingIdentifier("Back").elementBoundByIndex(0);
let girlButton = app.segmentedControls[Accessibility.GenderSegmentedControl].buttons["Girl"];
let boyButton = app.segmentedControls[Accessibility.GenderSegmentedControl].buttons["Boy"];
let firstQuestion = app.segmentedControls[Accessibility.Questions[0]];
let secondQuestion = app.segmentedControls[Accessibility.Questions[1]];
let thirdQuestion = app.segmentedControls[Accessibility.Questions[2]];
let ageSlider = app.sliders[Accessibility.AgeSlider];
let genderSegmentedControl = app.segmentedControls[Accessibility.GenderSegmentedControl];
let mainLabel = app.staticTexts[Accessibility.MainLabel];

let addPhotoButton = app.buttons["AddPhotoButton"]
let cameraPickImageButton = app.buttons["cameraPickImageButton"]
let photosPickImageButton = app.buttons["photosPickImageButton"]

let nextImageButton = app.buttons["nextImageButton"]
let previousImageButton = app.buttons["previousImageButton"]
let deleteImageButton = app.buttons["deleteImageButton"]

let deleteTheImageSheet = app.sheets["Delete the image?"]

let cancel = app.buttons["Cancel"]
let navigationPhotosCancel = app.navigationBars["Photos"].buttons["Cancel"]
let photoCaptureButton = app.buttons["PhotoCapture"]
let usePhotoButton = app.buttons["Use Photo"]
