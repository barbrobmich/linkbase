//
//  Language.swift
//  LinkBase
//
//  Created by Barbara Ristau on 4/3/17.
//  Copyright © 2017 barbrobmich. All rights reserved.
//

import Foundation
import Parse

class Language: NSObject {
    enum category {
        case Swift, Javascript, Java, Python
    }
}


class LanguageCollection: PFObject, PFSubclassing {
    
    static func parseClassName() -> String {
        return "LanguageCollection"
    }
    
    @NSManaged var user: PFUser?
    @NSManaged var language_name: String?
    @NSManaged var affiliations:[Affiliation]?
    @NSManaged var projects:[Project]?
    
    init(user: PFUser, langName: String, affiliations: [Affiliation], projects: [Project]) {
        super.init()
        
        self.user = user
        self.language_name = langName
        self.affiliations = affiliations
        self.projects = projects

    }
    
    override init() {
        super.init()
    }
    
    
    class func postLanguageCollectionToParse(collection: LanguageCollection, withCompletion completion: PFBooleanResultBlock?) {
        
        let Collection = PFObject(className: "LanguageCollection")
        Collection["language_name"] = collection.language_name
        
        let user = User.current()
        Collection["user_name"] = user?.username
        Collection["affiliations"] = collection.affiliations
        Collection["projects"] = collection.projects
        
        Collection.saveInBackground(block: completion)
    }
    
    class func updateLanguageCollection(collection: LanguageCollection, withCompletion completion: PFBooleanResultBlock?) {
        
        // Add relevant fields to the object
        collection["affiliations"] = collection.affiliations
        collection["projects"] = collection.projects
        
        // Save object (following function will save the object in Parse asynchronously)
        collection.saveInBackground(block: completion)
    }
}
