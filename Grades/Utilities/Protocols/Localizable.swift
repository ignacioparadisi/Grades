//
//  Localizable.swift
//  Grades
//
//  Created by Ignacio Paradisi on 3/30/20.
//  Copyright © 2020 Ignacio Paradisi. All rights reserved.
//

import Foundation

protocol Localizable {
    var tableName: String { get }
    var localized: String { get }
}

extension Localizable where Self: RawRepresentable, Self.RawValue == String {
    var localized: String {
        return rawValue.localized(tableName: tableName)
    }
}
