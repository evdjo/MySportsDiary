//
//  CustomSliderOut.swift
//  ScrollViewSpikeWork
//
//  Created by Evdzhan Mustafa on 17/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import UIKit

class CustomSliderOut: UIView {

	var color: UIColor? ;
	let scaleMultiplier = 100;
	var selectedValue = 50 {
		didSet {
			if (0 <= selectedValue && selectedValue < scaleMultiplier) {
				self.layer.setNeedsDisplay();
			} else {
				print("bad input\(selectedValue)");
			}
		}
	}

	override func drawRect(rect: CGRect) {

		let height = self.layer.frame.height;
		let width = self.layer.frame.width;

		// get the scaleed value
		let scale = CGFloat(selectedValue) / CGFloat(scaleMultiplier);

		// scale the width & height
		let scaledWidth = scale * width;
		let scaledHeight = height - scale * height;
		let path = UIBezierPath();

		print(scaledWidth);
		print(scaledHeight);

		// draw our triangle
		path.moveToPoint(CGPointMake(0, height));
		path.addLineToPoint(CGPointMake(scaledWidth, height));
		path.addLineToPoint(CGPointMake(scaledWidth, scaledHeight));
		path.addLineToPoint(CGPointMake(0, height));
		path.closePath();

		// default to black
		(color ?? UIColor.blackColor()).setFill();

		path.fill();
		let layer = CAShapeLayer();
		layer.path = path.CGPath;
		self.layer.mask = layer;
	}
}
