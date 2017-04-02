//
//  User.swift
//  LinkBase
//
//  Created by Barbara Ristau on 4/1/17.
//  Copyright © 2017 barbrobmich. All rights reserved.
//

import Foundation
import Parse

class User: PFUser {
    
    var firstname: String?
    var lastname: String?
    
    static let userDidLogout = "UserDidLogout"
    static let userDidSignUp = "UserDidSignUp"
    static let userDidLogIn = "UserDidLogIn"
    
    convenience init(_email: String, _password: String, firstname: String, lastname: String){
        
        self.init()
        
        username = _email
        email = _email
        password = _password
        add(firstname as Any, forKey: "firstname")
        add(lastname as Any, forKey: "lastname")
        
        print("Created a user")
  }
    
    
}
