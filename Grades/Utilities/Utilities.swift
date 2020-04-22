//
//  Utilities.swift
//  Grades
//
//  Created by Ignacio Paradisi on 3/29/20.
//  Copyright © 2020 Ignacio Paradisi. All rights reserved.
//

import Foundation

/// Defines whether the app is running in macOS or not
var isMacOS: Bool {
    #if targetEnvironment(macCatalyst)
    return true
    #else
    return false
    #endif
}

class Utilities {
}
