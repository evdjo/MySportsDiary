//
//  TestUtil.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 11/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation

internal func allASCIICharsAsString() -> String {
	var str = "";
	for i in 32 ... 126 {
		str.append(Character(UnicodeScalar(i)))
	}
	print(str);
	return str;
}