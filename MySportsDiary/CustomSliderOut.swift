//
//  CustomSliderOut.swift
//  ScrollViewSpikeWork
//
//  Created by Evdzhan Mustafa on 17/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import UIKit

class CustomSliderOut: UIView {
	static let minValue: Float = 0.0;
	static let maxValue: Float = 1.0;
	
	var scale: Float = 0.5 {
		didSet {
			if (CustomSliderOut.minValue <= scale
				&& scale <= CustomSliderOut.maxValue) {
					self.layer.setNeedsDisplay();
			} else {
					print("bad input \(scale)");
					scale = oldValue; // revert the change
			}
		}
	}
	
	override func drawRect(rect: CGRect) {
		let height = self.layer.frame.height;
		let width = self.layer.frame.width;
		
		// scale the width & height
		let scaledWidth = CGFloat(scale) * width;
		let scaledHeight = height - (CGFloat(scale) * height);
		let path = UIBezierPath();
		
		// draw our triangle
		path.moveToPoint(CGPointMake(0, height));
		path.addLineToPoint(CGPointMake(scaledWidth, height));
		path.addLineToPoint(CGPointMake(scaledWidth, scaledHeight));
		path.addLineToPoint(CGPointMake(0, height));
		path.closePath();
		
		// default to color
		(Config.appSliderColor).setFill();
		
		path.fill();
		let layer = CAShapeLayer();
		layer.path = path.CGPath;
		self.layer.mask = layer;
	}
}
