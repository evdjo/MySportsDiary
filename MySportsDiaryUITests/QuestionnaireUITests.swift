//
//  MySportsDiaryUITests.swift
//  MySportsDiaryUITests
//
//  Created by Evdzhan Mustafa on 12/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import XCTest

class QuestionnaireUITests: XCTestCase {
    
    private let maxAge: CGFloat = 65.0;
    private let girl = "Girl";
    private let boy = "Boy";
    
    private var app: XCUIApplication = XCUIApplication();
    private var beginButton = XCUIApplication().buttons["Begin"];
    private let nextButton = XCUIApplication().buttons["Next"];
    private let finishButton = XCUIApplication().buttons["Finish"];
    private let tabBarQuestionnaire = XCUIApplication().tabBars.buttons["Questionnaire"];
    private let tabBarFirst = XCUIApplication().tabBars.buttons["First"];
    private let tabBarSecond = XCUIApplication().tabBars.buttons["Second"];
    private let backButtonAgeGender = XCUIApplication().navigationBars["MySportsDiary.AgeGenderVC"]
    .childrenMatchingType(.Button).matchingIdentifier("Back").elementBoundByIndex(0);
    
    private let backButtonQuestions = XCUIApplication().navigationBars["MySportsDiary.QuestionsVC"]
    .childrenMatchingType(.Button).matchingIdentifier("Back").elementBoundByIndex(0);

    
    private let girlButton = XCUIApplication().segmentedControls["genderSegmentedControl"].buttons["Girl"];
    private let boyButton = XCUIApplication().segmentedControls["genderSegmentedControl"].buttons["Boy"];
    
    private let firstQuestion = XCUIApplication().segmentedControls["firstQuestion"];
    private let secondQuestion = XCUIApplication().segmentedControls["secondQuestion"];
    private let thirdQuestion = XCUIApplication().segmentedControls["thirdQuestion"];

    private let ageSlider = XCUIApplication().sliders["ageSlider"];
    private let genderSegmentedControl = XCUIApplication().segmentedControls["genderSegmentedControl"];
    
    
    override func setUp() {
        super.setUp();
        continueAfterFailure = false;
        let app = XCUIApplication();
        app.launchArguments.append("TEST_ENVIRONMENT");
        app.launch();
    }
    
    func testAnswerTheInitialQuestionnaireEnablesTheSecondAndThirdTabBar() {
        XCTAssertEqual(app.tabBars.buttons.count, 3);
        ///
        /// Assert only the first tab is enabled
        ///
        
        XCTAssertTrue(tabBarQuestionnaire.selected);
        XCTAssertFalse(tabBarFirst.selected);
        XCTAssertFalse(tabBarSecond.selected);
        tabBarFirst.tap();
        XCTAssertTrue(tabBarQuestionnaire.selected);
        XCTAssertFalse(tabBarFirst.selected);
        XCTAssertFalse(tabBarSecond.selected);
        tabBarSecond.tap();
        XCTAssertTrue(tabBarQuestionnaire.selected);
        XCTAssertFalse(tabBarFirst.selected);
        XCTAssertFalse(tabBarSecond.selected);
        ///
        /// Answer the questionnaire
        ///
        beginButton.tap();
        answerAgeAndGender(0.5, boyOrGirl: girl);
        nextButton.tap();
        answerQuestionnareOnCurrentPage([3,3,3]);
        nextButton.tap();
        answerQuestionnareOnCurrentPage([3,3,3]);
        nextButton.tap();
        answerQuestionnareOnCurrentPage([3,3,3]);
        finishButton.tap();
        app.sheets["Are you sure?"].collectionViews.buttons["Yes"].tap();
        ///
        /// Assert both tab bars are clickable and active
        ///
        app.staticTexts["Thanks for having answered the initial questionnaire. You will answer " +
            "the questionnaire again at the end. Now you can add new entries in the diary."].tap();
        tabBarFirst.tap();
        XCTAssertFalse(tabBarQuestionnaire.selected);
        XCTAssertTrue(tabBarFirst.selected);
        XCTAssertFalse(tabBarSecond.selected);
        tabBarSecond.tap();
        XCTAssertFalse(tabBarQuestionnaire.selected);
        XCTAssertFalse(tabBarFirst.selected);
        XCTAssertTrue(tabBarSecond.selected);
    }
    
    func testAgeAndGenderPersistenceNavigateBackAndForward() {
        ///
        /// Assert initial state
        ///
        beginButton.tap();
        XCTAssertFalse(girlButton.selected);
        XCTAssertFalse(boyButton.selected);
        XCTAssertEqual(ageSlider.normalizedSliderPosition, 0.0);
        XCTAssert(app.staticTexts["..."].exists);
        ///
        /// Modifiy the inital state
        ///
        answerAgeAndGender(1.0, boyOrGirl: girl);
        ///
        /// Navigate back, and then forward again
        ///
        backButtonAgeGender.tap();
        beginButton.tap();
        ///
        /// Assert state was preserved
        ///
        XCTAssertTrue(girlButton.selected);
        XCTAssertFalse(boyButton.selected);
        XCTAssertEqual(ageSlider.normalizedSliderPosition, 1.0);
        XCTAssert(app.staticTexts["65"].exists);
    }
    
    func testQuestionnaireAnswersPersistenceNavigateBackAndForwardPageOneToPageTwo() {
        beginButton.tap();
        answerAgeAndGender(0.5, boyOrGirl: boy);
        nextButton.tap();
        answerQuestionnareOnCurrentPage([2,5,2]);
        nextButton.tap();
        answerQuestionnareOnCurrentPage([3,4,3]);
        backButtonQuestions.tap();
        assertAnswersOnCurrentPage([2,5,2])
        nextButton.tap();
        assertAnswersOnCurrentPage([3,4,3])
    }
    
    
    func testQuestionnaireAnswersPersistenceNavigateBackAndForwardPageOneToPageThree() {
        beginButton.tap();
        answerAgeAndGender(0.5, boyOrGirl: boy);
        nextButton.tap();
        answerQuestionnareOnCurrentPage([2,5,2]);
        nextButton.tap();
        answerQuestionnareOnCurrentPage([3,4,3]);
        nextButton.tap();
        answerQuestionnareOnCurrentPage([4,3,4]);
        backButtonQuestions.tap();
        backButtonQuestions.tap();
        backButtonQuestions.tap();
        
        nextButton.tap();
        assertAnswersOnCurrentPage([2,5,2])
        nextButton.tap();
        assertAnswersOnCurrentPage([3,4,3])
        nextButton.tap();
        assertAnswersOnCurrentPage([4,3,4])
    }
    
    func testQuestionnaireAnswersPersistenceAppRestartPageThree(){
        ///
        /// Answer the questionnaire
        ///
        beginButton.tap();
        answerAgeAndGender(1.0, boyOrGirl: boy);
        nextButton.tap();
        answerQuestionnareOnCurrentPage([1,3,5]);
        nextButton.tap();
        answerQuestionnareOnCurrentPage([1,2,3]);
        nextButton.tap();
        answerQuestionnareOnCurrentPage([4,4,4]);
        ///
        /// Restart the app, without pressing Finish button
        ///
        XCUIDevice().pressButton(XCUIDeviceButton.Home)
        sleep(1); // give time to the main process to handle the home button press...
        app.terminate();
        app.launch();
        ///
        /// See if values persisted
        ///
        beginButton.tap();
        assertAgeAndGender(65, boyOrGirl: boy);
        nextButton.tap();
        assertAnswersOnCurrentPage([1,3,5]);
        nextButton.tap();
        assertAnswersOnCurrentPage([1,2,3]);
        nextButton.tap();
        assertAnswersOnCurrentPage([4,4,4]);
    }
    
    
    func testQuestionnaireAnswersPersistenceAppRestartPageTwo(){
        ///
        /// Answer the questionnaire
        ///
        beginButton.tap();
        answerAgeAndGender(1.0, boyOrGirl: boy);
        nextButton.tap();
        answerQuestionnareOnCurrentPage([1,3,5]);
        nextButton.tap();
        answerQuestionnareOnCurrentPage([1,2,3]);

        ///
        /// Restart the app, without pressing Finish button
        ///
        XCUIDevice().pressButton(XCUIDeviceButton.Home)
        sleep(1); // give time to the main process to handle the home button press...
        app.terminate();
        app.launch();
        ///
        /// See if values persisted
        ///
        beginButton.tap();
        assertAgeAndGender(65, boyOrGirl: boy);
        nextButton.tap();
        assertAnswersOnCurrentPage([1,3,5]);
        nextButton.tap();
        assertAnswersOnCurrentPage([1,2,3]);
    }
    
    func testQuestionnaireAnswersPersistenceAppRestartPageOne(){
        ///
        /// Answer the questionnaire
        ///
        beginButton.tap();
        answerAgeAndGender(1.0, boyOrGirl: boy);
        nextButton.tap();
        answerQuestionnareOnCurrentPage([1,3,5]);

        ///
        /// Restart the app, without pressing Finish button
        ///
        XCUIDevice().pressButton(XCUIDeviceButton.Home)
        sleep(1); // give time to the main process to handle the home button press...
        app.terminate();
        app.launch();
        ///
        /// See if values persisted
        ///
        beginButton.tap();
        assertAgeAndGender(65, boyOrGirl: boy);
        nextButton.tap();
        assertAnswersOnCurrentPage([1,3,5]);
    }
    
    func testAgeAndGenderPersistenceAppRestart(){
        ///
        /// Answer the questionnaire
        ///
        beginButton.tap();
        answerAgeAndGender(1.0, boyOrGirl: boy);
        ///
        /// Restart the app, without pressing Finish button
        ///
        XCUIDevice().pressButton(XCUIDeviceButton.Home)
        sleep(1); // give time to the main process to handle the home button press...
        app.terminate();
        app.launch();
        ///
        /// See if values persisted
        ///
        beginButton.tap();
        assertAgeAndGender(65, boyOrGirl: boy);

    }
    
    
    func testAgeAndGenderSetGenderThenAgeEnablesNextButton() {
    
    
    beginButton.tap();
    genderSegmentedControl.buttons[girl].tap();
    ageSlider.adjustToNormalizedSliderPosition(0.5);
    
    XCTAssert(nextButton.enabled)
    
    
    }



    
    ///
    /// Answer functions
    ///
    private func answerAgeAndGender(sliderValue: CGFloat, boyOrGirl: String) {
        ageSlider.adjustToNormalizedSliderPosition(sliderValue);
        genderSegmentedControl.buttons[boyOrGirl].tap();
    }
    
    private func answerQuestionnareOnCurrentPage(values:[Int]) {
        firstQuestion.buttons[String(values[0])].tap();
        secondQuestion.buttons[String(values[1])].tap();
        thirdQuestion.buttons[String(values[2])].tap();
    }
    
    
    ///
    /// Assertions
    ///
    private func assertAgeAndGender(age: Int, boyOrGirl: String) {
        XCTAssertEqual(Int(ageSlider.normalizedSliderPosition * maxAge), age);
        XCTAssertEqual(selectedGender(genderSegmentedControl),boyOrGirl);
        XCTAssert(app.staticTexts[String(age)].exists);
    }
    
    private func assertAnswersOnCurrentPage(values: [Int]) {
        XCTAssertEqual(selectedAnswer(firstQuestion), values[0]);
        XCTAssertEqual(selectedAnswer(secondQuestion), values[1]);
        XCTAssertEqual(selectedAnswer(thirdQuestion), values[2]);
    }
    
    private func selectedAnswer(segmentedControls: XCUIElement) -> Int {
        for i in 1...5 {
            if(segmentedControls.buttons[String(i)].selected){
                return i;
            }
        }
        XCTFail("No answer was selected!");
        return -1;
    }
    
    private func selectedGender(segmentedControls: XCUIElement) -> String {
        if(segmentedControls.buttons[boy].selected){
            return "Boy";
        } else if(segmentedControls.buttons["Girl"].selected){
            return "Girl";
        }
        XCTFail("No gender was selected!");
        return "";
    }
}