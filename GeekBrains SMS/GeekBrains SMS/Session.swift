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
}
