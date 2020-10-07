//
//  Session.swift
//  GeekBrains SMS
//
//  Created by Дмитрий Канский on 19.08.2020.
//  Copyright © 2020 ernokanst. All rights reserved.
//

import Foundation
import WebKit


class Session {
    
    static let instance = Session()
    private init(){}
    
    var loginData = ["login":"password"]
    var login = ""
    var loginID: [String : Int] = [:]
    var loginList: [String] = []
    var nameData: [String : String] = [:]
    var emailData = ["login":"12w8w21@gmail.com"]
    var phoneData = ["login":"88005553535"]
    var roleData = ["login":1]
    var temp = ""
    var token = ""
}
