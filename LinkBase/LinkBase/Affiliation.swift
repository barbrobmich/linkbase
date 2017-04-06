//
//  Affiliation.swift
//  LinkBase
//
//  Created by Barbara Ristau on 4/2/17.
//  Copyright © 2017 barbrobmich. All rights reserved.
//

import Foundation
import Parse
import CoreData



class Affiliation: PFObject, PFSubclassing {
    
    enum category {
        case Education, Professional, Community, Other
    }
    
    static func parseClassName() -> String {
        return "Affiliation"
    }
    
    @NSManaged var user: PFUser?
    @NSManaged var name: String?
    @NSManaged var affiliationImage: PFFile?
    
    init(user: PFUser, name: String?) {
        super.init()
        
        self.user = user
        self.name = name
    }
    
    override init() {
        super.init()
    }
    
    
    class func postAffiliationToParse(affiliation: Affiliation, withCompletion completion: PFBooleanResultBlock?) {
        
        let Affiliation = PFObject(className: "Affiliation")
        Affiliation["name"] = affiliation.name
    
        let user = PFUser.current()
        Affiliation["user"] = user?.username
        Affiliation.saveInBackground(block: completion)
        
    }
}


