//
//  Address.swift
//  LinkBase
//
//  Created by Rob Hernandez on 4/5/17.
//  Copyright © 2017 barbrobmich. All rights reserved.
//

import UIKit
import MapKit
import Parse

class Address: NSObject {
    var address1: String?
    var city:     String?
    var zip:      String?
    var state:    String?
    var latitude: CLLocationDegrees?
    var longitude:CLLocationDegrees?
    var user:     PFUser?
    
    
    init(lat: CLLocationDegrees, long: CLLocationDegrees){
        self.latitude = lat
        self.longitude = long
    }
    
    func setLocationfromSelf(){
        self.getAddressFromGPS(latitude: self.latitude!, longitude: self.longitude!)
    }
    
    func getAddressFromGPS(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        geoCoder.reverseGeocodeLocation(location)
        {
            (placemarks, error) -> Void in
            
            let placeArray = placemarks as [CLPlacemark]!
            
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placeArray?[0]
            
            // Address dictionary
            print(placeMark.addressDictionary)
            
            // Location name
            if let locationName = placeMark.addressDictionary?["Name"] as? NSString
            {
                print(locationName)
            }
            
            // Street address
            if let street = placeMark.addressDictionary?["Thoroughfare"] as? NSString
            {
                print(street)
                self.address1 = street as String
            }
            
            // City
            if let city = placeMark.addressDictionary?["City"] as? NSString
            {
                print(city)
                self.city = city as String
            }
            
            // Zip code
            if let zip = placeMark.addressDictionary?["ZIP"] as? NSString
            {
                print(zip)
                self.zip = zip as String
            }
            
            // Country
            if let country = placeMark.addressDictionary?["Country"] as? NSString
            {
                print(country)
            }
            // State
            if let state = placeMark.addressDictionary?["State"] as? String{
                self.state = state
            }
        }
    }
    
    /**
     Method to add a user post to Parse (uploading image file)
     
     - parameter image: Image that the user wants upload to parse
     - parameter caption: Caption text input by the user
     - parameter completion: Block to be executed after save operation is complete
     */
    func postAddress(user: User, withCompletion completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        let post = PFObject(className: "Address")
        
        // Add relevant fields to the object
        post["author"] = user // Pointer column type that points to PFUser
        post["address"] = self.address1 ?? ""
        post["city"]   = self.city ?? ""
        post["zip"] = self.zip ?? ""
        post["state"] = self.state ?? ""
        post["lat"] = self.latitude ?? 0
        post["long"] = self.longitude ?? 0
        
        //tell that user that it has an address
        user.hasAddress = true
        
        
        
        // Save object (following function will save the object in Parse asynchronously)
        post.saveInBackground(block: completion)
    }
    
}
