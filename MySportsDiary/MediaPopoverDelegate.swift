//
//  MediaPopoverDelegate.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 13/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import UIKit

class MediaPopoverDelegate: NSObject, UIPopoverPresentationControllerDelegate {

	let originVC: UIViewController;
	init(originVC: UIViewController) {
		self.originVC = originVC;
	}

	func popoverPresentationControllerDidDismissPopover(controller: UIPopoverPresentationController) {
		originVC.view.alpha = 1.0;
	}
	func adaptivePresentationStyleForPresentationController(_: UIPresentationController) -> UIModalPresentationStyle {
		return .None;
	}
}
