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

