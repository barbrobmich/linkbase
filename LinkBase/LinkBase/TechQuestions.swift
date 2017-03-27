//
//  TechQuestions.swift
//  LinkBase
//
//  Created by Barbara Ristau on 3/27/17.
//  Copyright © 2017 barbrobmich. All rights reserved.
//

import Foundation

struct TechQuestion {
    
    var question: String?
    var questionID: Int?
    var ans1: String?
    var ans2: String?
    var ans3: String?
    var ans4: String?
    var correctResponse: String?
    
    init() {
        question = "What is Big O notation for the following problem?"
        questionID = 1;
        ans1 = "O(1)"
        ans2 = "None of the above"
        ans3 = "All of the above"
        ans4 = "O(n^2)"
    }
}

struct TechQuestionList {
    
    var techList: [TechQuestion] = []
    var placeholder: TechQuestion?
    
    init() {
        
        placeholder = TechQuestion()
        techList.append(placeholder!)
        
    }
    
}
