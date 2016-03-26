//
//  MySportsDiaryUITests.swift
//  MySportsDiaryUITests
//
//  Created by Evdzhan Mustafa on 12/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import XCTest

class MySportsDiaryUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        let app = XCUIApplication()
        app.launchArguments.append("TEST_ENVIRONMENT");
        app.launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAnswerTheInitialQuestionnaireEnablesTheSecondAndThirdTabBar() {
        
        let app = XCUIApplication()
                
        var tabBarsButtons = app.tabBars.buttons;
        XCTAssertEqual(tabBarsButtons.count, 3)
        XCTAssertTrue(tabBarsButtons["Questionnaire"].selected)
        XCTAssertFalse(tabBarsButtons["First"].selected)
        XCTAssertFalse(tabBarsButtons["Second"].selected)
        
        
        XCUIApplication().tabBars.buttons["First"].tap()
        XCTAssertTrue(tabBarsButtons["Questionnaire"].selected)
        XCTAssertFalse(tabBarsButtons["First"].selected)
        XCTAssertFalse(tabBarsButtons["Second"].selected)
        
        XCUIApplication().tabBars.buttons["Second"].tap()
        XCTAssertTrue(tabBarsButtons["Questionnaire"].selected)
        XCTAssertFalse(tabBarsButtons["First"].selected)
        XCTAssertFalse(tabBarsButtons["Second"].selected)
        
        
        app.buttons["Begin"].tap()
        app.buttons["Girl"].tap()
        app.sliders["0%"].tap()
        
        let nextButton = app.buttons["Next"]
        nextButton.tap()
        
        let element = app.childrenMatchingType(.Window).elementBoundByIndex(0).childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element
        let neutral50Button = element.childrenMatchingType(.SegmentedControl).elementBoundByIndex(2).buttons["Neutral 50"]
        neutral50Button.tap()
        
        let neutral50Button2 = element.childrenMatchingType(.SegmentedControl).elementBoundByIndex(1).buttons["Neutral 50"]
        neutral50Button2.tap()
        
        let neutral50Button3 = element.childrenMatchingType(.SegmentedControl).elementBoundByIndex(0).buttons["Neutral 50"]
        neutral50Button3.tap()
        nextButton.tap()
        neutral50Button.tap()
        neutral50Button2.tap()
        neutral50Button3.tap()
        nextButton.tap()
        neutral50Button.tap()
        neutral50Button2.tap()
        neutral50Button3.tap()
        app.buttons["Finish"].tap()
        app.sheets["Are you sure?"].collectionViews.buttons["Yes"].tap()
        app.staticTexts["Thanks for having answered the initial questionnaire. You will answer the questionnaire again at the end. Now you can add new entries in the diary."].tap()
        
        
        tabBarsButtons = app.tabBars.buttons;
        XCTAssertEqual(tabBarsButtons.count, 3)
        
        XCUIApplication().tabBars.buttons["First"].tap()
        XCTAssertFalse(tabBarsButtons["Questionnaire"].selected)
        XCTAssertTrue(tabBarsButtons["First"].selected)
        XCTAssertFalse(tabBarsButtons["Second"].selected)
        
        XCUIApplication().tabBars.buttons["Second"].tap()
        XCTAssertFalse(tabBarsButtons["Questionnaire"].selected)
        XCTAssertFalse(tabBarsButtons["First"].selected)
        XCTAssertTrue(tabBarsButtons["Second"].selected)
    }
    
    func testAgeAndGenderPersistence() {
        
        
        
        let app = XCUIApplication()
        let beginButton = app.buttons["Begin"]
        
        /// assert no gender is selected and no age is selected
        
        
        beginButton.tap()
        app.sliders["0%"].tap()
        app.buttons["Girl"].tap()
        app.navigationBars["MySportsDiary.AgeGenderVC"].childrenMatchingType(.Button).matchingIdentifier("Back").elementBoundByIndex(0).tap()
        beginButton.tap()
        
        
        
        
    }
    
    func testQuestionnaireAnswersPersistnce(){
    
    }
    
    
}

