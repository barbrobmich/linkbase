//
//  ScoreCard.swift
//  LinkBase
//
//  Created by Barbara Ristau on 3/28/17.
//  Copyright © 2017 barbrobmich. All rights reserved.
//

import Foundation

class ScoreCard {
    
    var player: String?
    var techQuestionsAnswered: [TechQuestion]
    var commsQuestionsAnswered: [CommsQuestion]
    var grader: String?
    var dateGraded: Date?
    
    init(playerName: String) {
        
        player = playerName
        techQuestionsAnswered = []
        commsQuestionsAnswered = []
        // currently this initializes the ScoreCard with empty arrays.  Need to modify this so that scores can be persisted.
        
    }
}
