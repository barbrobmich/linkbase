//
//  CommsQuestion.swift
//  LinkBase
//
//  Created by Barbara Ristau on 3/27/17.
//  Copyright © 2017 barbrobmich. All rights reserved.
//

import Foundation

struct CommsQuestion {
    
    var question: String?
    var questionID: Int?
    
    init() {
        question = "Why did you decide to study computer science?"
        questionID = 1;
    }
}

struct CommsQuestionList {

    var commsList: [CommsQuestion] = []
    var placeholder: CommsQuestion?
    
    init() {
       
        placeholder = CommsQuestion()
        commsList.append(placeholder!)
        
    }
    
}
