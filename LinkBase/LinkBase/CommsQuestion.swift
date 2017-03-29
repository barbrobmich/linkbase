//
//  CommsQuestion.swift
//  LinkBase
//
//  Created by Barbara Ristau on 3/27/17.
//  Copyright © 2017 barbrobmich. All rights reserved.
//

import Foundation

struct Points {
    
    var submit: Int
    var overall: Int
    var style: Int
    var relevance: Int
}

struct CommsQuestion {
    
    var question: String
    var points: Points
    var date: Date?
    var audioFile: URL?

}
    
struct CommsQuestionList {
    
    var commList: [CommsQuestion] = [
      
        CommsQuestion(question: "Why did you decide to study computer science?", points: Points.init(submit: 0, overall: 0, style: 0, relevance: 0), date: nil, audioFile: nil),
        CommsQuestion(question: "Where did you grow up?", points: Points.init(submit: 0, overall: 0, style: 0, relevance: 0), date: nil, audioFile: nil),
        CommsQuestion(question: "What's your favorite food?", points: Points.init(submit: 0, overall: 0, style: 0, relevance: 0), date: nil, audioFile: nil)

    ]

}
