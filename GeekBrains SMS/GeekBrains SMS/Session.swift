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
    
    var login = ""
    var loginID: [String : Int] = [:]
    var loginList: [String] = []
    var nameData: [String : String] = [:]
    var categoryList: [String] = []
    var categoryID: [String : Int] = [:]
    var temp = ""
    var token = ""
    var products: [CategoryController.FundResponse] = []
    var contractorList: [String] = []
    var contractorID: [String : Int] = [:]
}
