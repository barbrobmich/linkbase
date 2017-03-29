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
