//
//  Student.swift
//  iSWAD
//
//  Created by Raul Alvarez on 18/05/16.
//  Copyright © 2016 Raul Alvarez. All rights reserved.
//

import Foundation

class Student: NSObject  {
    var userName: String;
    var password: String;
    var userID: String;
    var userFirstName: String;
    var userSurname1: String;
    var userSurname2: String;
    override init(){
        userID = ""
        userName = ""
        password = ""
        userFirstName = ""
        userSurname1 = ""
        userSurname2 = ""
    }
}
