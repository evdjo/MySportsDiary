//
//  ImagePickerPopoverVCUITests.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 03/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import XCTest

class ImagePickerPopoverVCUITests: XCTestCase {

    override func setUp() {
        super.setUp();
        continueAfterFailure = false;
        app.launchArguments.append("DELETE_TEMP_MEDIA");
        app.launch();
    }

    func testPickingImageFromCameraIncreasesCounterLabel() {
        for i in 1 ... 5 {
            addPhotoButton.tap()
            cameraPickImageButton.tap()
            photoCaptureButton.tap()
            _ = self.expectationForPredicate(NSPredicate(format: "self.exists = true"),
                evaluatedWithObject: usePhotoButton, handler: nil);
            self.waitForExpectationsWithTimeout(5.0, handler: nil)
            usePhotoButton.tap()
            XCTAssertTrue(app.staticTexts["\(i)"].exists)
            addPhotoButton.tap()
        }
    }

    
}
