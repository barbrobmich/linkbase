//
//  Company.swift
//  LinkBase
//
//  Created by Rob Hernandez on 3/29/17.
//  Copyright © 2017 barbrobmich. All rights reserved.
//

import UIKit

class Company: NSObject {
    
    // Generated by Parse
    var id: Int = 0
    var name: String
    var numEmployees: Int = 0
    //var address: Address Todo, make Address Model
    //var event: Event Todo, make Event Model

    
    init(id: Int, name: String, numEmployees: Int){
        self.id = id
        self.name = name
        self.numEmployees = numEmployees
    }
}