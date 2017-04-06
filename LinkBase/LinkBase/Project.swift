//
//  Project.swift
//  LinkBase
//
//  Created by Barbara Ristau on 4/3/17.
//  Copyright © 2017 barbrobmich. All rights reserved.
//

import Foundation
import Parse
import CoreData

class Project: PFObject, PFSubclassing {
    
    enum category {
        case GitHub, Hackathon, Community, Other
    }
    
    static func parseClassName() -> String {
        return "Project"
    }
    
    @NSManaged var user: PFUser?
    @NSManaged var name: String?
    @NSManaged var projectImage: PFFile?
    
    init(user: PFUser, name: String?) {
        super.init()
        
        self.user = user
        self.name = name
    }
    
    override init() {
        super.init()
    }
    
    
    class func postProjectToParse(project: Project, withCompletion completion: PFBooleanResultBlock?) {
        
        let Project = PFObject(className: "Project")
        Project["name"] = project.name
        
        let user = User.current()
        Project["user"] = user?.username
        Project.saveInBackground(block: completion)
        
    }
}

