//
//  TechQuestions.swift
//  LinkBase
//
//  Created by Barbara Ristau on 3/27/17.
//  Copyright © 2017 barbrobmich. All rights reserved.
//

import Foundation

struct TechQuestion {
    
    var question: String
    var answers: [String]
    var correctAnswer: Int
    
}

struct TechQuestionList {
    
    var techList: [TechQuestion] = [
        
        TechQuestion(question: "What type of animal is this", answers: ["armadillo","mouse", "cat", "dog" ], correctAnswer: 2),
        
        TechQuestion(question: "How many seasons are in a year", answers: ["four", "two", "one", "three"], correctAnswer: 0),
        
        TechQuestion(question: "What color is the sun", answers: ["purple", "green", "blue", "yellow"], correctAnswer: 3)
    ]
}
