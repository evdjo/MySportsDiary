//
//  GPSLocationGetter.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 16/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import UIKit
import CoreLocation

///
/// The class gets single GPS coordinate and stops asking
/// for update when it gets one
///
///
class GPSLocationGetter: NSObject, CLLocationManagerDelegate {
	private let locationManager = CLLocationManager();
	private let parentVC: UIViewController;
	private var lastLocation: CLLocation?;
	private var isGPSActive = false;
	
///
/// Initialize with the parentVC so we can send messages to it if needed
///
	init(parentVC: UIViewController) {
		self.parentVC = parentVC;
		super.init();
		locationManager.requestWhenInUseAuthorization();
		locationManager.delegate = self;
	}
///
/// Ask for a location if there is one.
///
	func getLocation() -> CLLocation? {
		if nil == lastLocation { locationManager.startUpdatingLocation() }
		return lastLocation;
	}
///
/// Stop asking for updates
///
	func stop() {
		if isGPSActive { locationManager.stopUpdatingLocation() }
		isGPSActive = false;
	}
///
/// When authorisation status changes.
///
	func locationManager(manager: CLLocationManager,
		didChangeAuthorizationStatus status: CLAuthorizationStatus) {
			switch (status) {
			case .AuthorizedWhenInUse, .AuthorizedAlways:
				isGPSActive = true;
				locationManager.startUpdatingLocation();
			default:
				isGPSActive = false;
				locationManager.stopUpdatingLocation();
			}
	}
///
/// When a failure occurs just print it for now
///
	func locationManager(manager: CLLocationManager,
		didFailWithError error: NSError) {
			let errorType = error.code == CLError.Denied.rawValue ?
			"Access Denied" : "Error \(error.code)" ;
			print(errorType);
	}
///
/// When we get new location, stop asking for new locations
/// and record the last one
///
	func locationManager(manager: CLLocationManager, didUpdateLocations
		locations: [CLLocation]) {
			if let newLoc = locations.last where lastLocation != newLoc {
				lastLocation = newLoc;
				locationManager.stopUpdatingLocation();
				isGPSActive = false;
			} else {
				// no op
			}
	}
}
