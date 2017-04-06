//
//  Language.swift
//  LinkBase
//
//  Created by Barbara Ristau on 4/3/17.
//  Copyright © 2017 barbrobmich. All rights reserved.
//

import Foundation
import Parse

class Language: PFObject, PFSubclassing {
    
    enum category {
        case Swift, Javascript, Java, Python
    }
    
    static func parseClassName() -> String {
        return "Language"
    }
    
    @NSManaged var user: PFUser?
    @NSManaged var name: String?
    @NSManaged var languageImage: PFFile?
    
    init(user: PFUser, name: String?) {
        super.init()
        
        self.user = user
        self.name = name
    }
    
    override init() {
        super.init()
    }
    
    
    class func postLanguageToParse(language: Language, withCompletion completion: PFBooleanResultBlock?) {
        
        let Language = PFObject(className: "Language")
        Language["name"] = language.name
        
        let user = User.current()
        Language["user"] = user?.username
        Language.saveInBackground(block: completion)
        
    }

    
}
