//
//  Utilities.swift
//  Grades
//
//  Created by Ignacio Paradisi on 3/29/20.
//  Copyright © 2020 Ignacio Paradisi. All rights reserved.
//

import Foundation

class Utilities {
    /// Executes a piece of code depending if the app is running in macOS or not
    /// - Parameter handler: Code to be executed depending on device
    static func setupForMac(_ handler: (Bool) -> Void) {
        #if targetEnvironment(macCatalyst)
        handler(true)
        #else
        handler(false)
        #endif
    }
}
