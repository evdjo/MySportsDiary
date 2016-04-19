//
//  GPSLocationGetter.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 16/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import UIKit
import CoreLocation

class GPSLocationGetter: NSObject, CLLocationManagerDelegate {

	private let locationManager = CLLocationManager();
	private let parentVC: UIViewController;
	private var lastLocation: CLLocation?;
	private var isGPSActive = false;

	init(parentVC: UIViewController) {
		self.parentVC = parentVC;
		super.init();

		locationManager.requestWhenInUseAuthorization();
		locationManager.delegate = self;
	}

	internal func getLocation() -> CLLocation? {
		if lastLocation == nil {
			self.locationManager.startUpdatingLocation();
		}
		return lastLocation;
	}

	internal func stop() {
		if isGPSActive {
			locationManager.stopUpdatingLocation();
		}
		isGPSActive = false;
	}

	func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
		switch (status) {
		case .AuthorizedWhenInUse, .AuthorizedAlways:
			isGPSActive = true;
			locationManager.startUpdatingLocation();
		default:
			isGPSActive = false;
			locationManager.stopUpdatingLocation();
		}
	}

	func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
		let errorType = error.code == CLError.Denied.rawValue ? "Access Denied" : "Error \(error.code)" ;
		print(errorType);
		// alertWithMessage(parentVC, title: "Failed to get the location.", message: errorType);
	}

	func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		if let newLocation = locations.last where lastLocation != newLocation {
			lastLocation = newLocation;
			locationManager.stopUpdatingLocation();
			isGPSActive = false;
		}
	}
}
