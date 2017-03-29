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

}
    
struct CommsQuestionList {
    
    var commList: [CommsQuestion] = [
      CommsQuestion(question: "Why did you decide to study computer science"),
      CommsQuestion(question: "Where did you grow up?"),
      CommsQuestion(question: "What's your favorite food?")
]

}
