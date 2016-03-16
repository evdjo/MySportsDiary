//
//  File.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 13/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation


protocol DataManagerDelegate {

    func getAge()-> Int?
    func getGender()-> Gender?
    func setAge(age:Int)
    func setGender(gender:Gender)

}


enum Gender : Int {
   case BOY = 1
   case GIRL = 2
}