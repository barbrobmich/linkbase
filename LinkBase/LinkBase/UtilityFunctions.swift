//
//  UtilityFunctions.swift
//  LinkBase
//
//  Created by Barbara Ristau on 3/27/17.
//  Copyright © 2017 barbrobmich. All rights reserved.
//

import Foundation
import Dispatch

// function to use in HUD

func afterDelay(_ seconds: Double, closure: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: closure)
}


// This function is used to generate a random number. The parameter count represents the size of the array.  The value returned is an element in the array.  This is used to generate randomly selected questions in both the tech and comms challenge view controllers.  

func getRandomNumber(count: Int) -> Int {
   
    let randomIndex = Int(arc4random_uniform(UInt32(count)))
   
    print("Number of Items: \(count), RandomIndex: \(randomIndex)")
    return randomIndex
}


func getDocumentsDirectory() -> URL {
    
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentsDirectory = paths[0]
    print(paths[0])
    return documentsDirectory
}

// this method is used in the temp profiles in the PeerReviewViewController
func getDateFromPriorWeek(currentDate: Date, numWeeks: Int) -> Date {
    
    var newDate = Date()
    let week = 604800
    let numSeconds = week * numWeeks
    
    newDate = currentDate - TimeInterval(numSeconds)
 
    return newDate
}
