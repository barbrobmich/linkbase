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
    var weirdFact: String?
    
    static let userDidLogout = "UserDidLogout"
    static let userDidSignUp = "UserDidSignUp"
    static let userDidLogIn = "UserDidLogIn"
    
    convenience init(_email: String, _password: String, _firstname: String, _lastname: String){
        
        self.init()
        
        username = _email
        email = _email
        password = _password
        firstname = _firstname
        lastname = _lastname
        setObject(firstname!, forKey: "firstname")
        setObject(lastname!, forKey: "lastname")

        print("Created a user")
  }
    
    
  class func updateProfileData(fname: String, lname: String, email: String, weirdFact: String, withCompletion completion: PFBooleanResultBlock?) {
 
            let currentUser = User.current()!
    
            // update user fields
            currentUser.firstname = fname
            currentUser.lastname = lname
            currentUser.email = email
            currentUser.username = email // check on this   
            currentUser.weirdFact = weirdFact
    
    
            // Add relevant fields to the PFUser object
            currentUser["firstname"] = currentUser.firstname
            currentUser["lastname"] = currentUser.lastname
            currentUser["email"] = currentUser.email
            currentUser["username"] = currentUser.email // do we need to add validation here in case user name is taken?
            currentUser["weird_fact"] = currentUser.weirdFact
            // Save object (following function will save the object in Parse asynchronously)
            currentUser.saveInBackground(block: completion)
            
    
    }
    
    class func saveProfileImage(image: UIImage?, withCompletion completion: PFBooleanResultBlock?) {
        
        let currentUser = User.current()!
        
        // Add relevant fields to the object
        currentUser["profile_image"] = getPFFileFromImage(image: image) // PFFile column type
        
        // Save object (following function will save the object in Parse asynchronously)
        currentUser.saveInBackground(block: completion)
    }
    
    
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
    
}
