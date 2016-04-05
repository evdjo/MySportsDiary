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

    func testPickingImageFromPhotosIncreasesCounterLabel() {
        for i in 1 ... 5 {
            addPhotoButton.tap()
            photosPickImageButton.tap()
            cameraRollButton.tap()
            photosgridviewCollectionView.cells.elementBoundByIndex(UInt(i - 1)).tap()
            XCTAssertTrue(app.staticTexts["\(i)"].exists)
            addPhotoButton.tap()
        }
    }

    func testDeletingPhotoPickedFromPhotosDecreasesCounterLabel() {
        for i in 1 ... 5 {
            addPhotoButton.tap()
            photosPickImageButton.tap()
            cameraRollButton.tap()
            photosgridviewCollectionView.cells.elementBoundByIndex(UInt(i - 1)).tap()
            XCTAssertTrue(app.staticTexts["\(i)"].exists)
            addPhotoButton.tap()
        }

        for i in(1 ... 5).reverse() {
            XCTAssertTrue(app.staticTexts["\(i)"].exists)
            addPhotoButton.tap()
            deleteImageButton.tap()
            deleteTheImageSheet.collectionViews.buttons["Yes"].tap()
            addPhotoButton.tap()
        }
    }

    func testDeletingPhotoPickedFromCameraDecreasesCounterLabel() {
        for _ in 1 ... 5 {
            addPhotoButton.tap()
            cameraPickImageButton.tap()
            photoCaptureButton.tap()
            _ = self.expectationForPredicate(NSPredicate(format: "self.exists = true"),
                evaluatedWithObject: usePhotoButton, handler: nil);
            self.waitForExpectationsWithTimeout(5.0, handler: nil)

            usePhotoButton.tap()
            addPhotoButton.tap()
        }

        for i in(1 ... 5).reverse() {
            XCTAssertTrue(app.staticTexts["\(i)"].exists)
            addPhotoButton.tap()
            deleteImageButton.tap()
            deleteTheImageSheet.collectionViews.buttons["Yes"].tap()
            addPhotoButton.tap()
        }
    }

    func testNoImagesLabelPresentThenReplacedByImageFromCamera() {

        addPhotoButton.tap();
        XCTAssertTrue(app.staticTexts["No photos added"].hittable);
        cameraPickImageButton.tap();
        photoCaptureButton.tap();
        _ = self.expectationForPredicate(NSPredicate(format: "self.exists = true"),
            evaluatedWithObject: usePhotoButton, handler: nil);
        self.waitForExpectationsWithTimeout(5.0, handler: nil);
        usePhotoButton.tap();
        XCTAssertFalse(app.staticTexts["No photos added"].hittable);
    }

    func testNoImagesLabelPresentThenReplacedByImageFromPhotos() {
        addPhotoButton.tap()
        XCTAssertTrue(app.staticTexts["No photos added"].hittable);
        photosPickImageButton.tap()
        cameraRollButton.tap()
        photosgridviewCollectionView.cells.elementBoundByIndex(0).tap()
        _ = self.expectationForPredicate(NSPredicate(format: "self.exists = true"),
            evaluatedWithObject: app.images["TheImageView"], handler: nil);
        self.waitForExpectationsWithTimeout(5.0, handler: nil)
        XCTAssertFalse(app.staticTexts["No photos added"].hittable);
    }

    func testNoImagesLabelAppearsAgainWhenAllImagesDeletedImagePickedFromPhotos() {

        addPhotoButton.tap()
        XCTAssertTrue(app.staticTexts["No photos added"].hittable);

        photosPickImageButton.tap()
        cameraRollButton.tap()
        photosgridviewCollectionView.cells.elementBoundByIndex(0).tap()
        deleteImageButton.tap()
        deleteTheImageSheet.collectionViews.buttons["Yes"].tap()
        XCTAssertTrue(app.staticTexts["No photos added"].hittable);
    }

    func testNoImagesLabelAppearsAgainWhenAllImagesDeletedImagePickedFromCamera() {

        addPhotoButton.tap()
        XCTAssertTrue(app.staticTexts["No photos added"].hittable);
        cameraPickImageButton.tap()
        photoCaptureButton.tap()
        _ = self.expectationForPredicate(NSPredicate(format: "self.exists = true"),
            evaluatedWithObject: usePhotoButton, handler: nil);
        self.waitForExpectationsWithTimeout(5.0, handler: nil)
        usePhotoButton.tap();

        deleteImageButton.tap()
        deleteTheImageSheet.collectionViews.buttons["Yes"].tap()
        XCTAssertTrue(app.staticTexts["No photos added"].hittable);
    }
}
