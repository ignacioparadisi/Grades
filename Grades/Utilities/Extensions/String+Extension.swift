//
//  String+Extension.swift
//  Grades
//
//  Created by Ignacio Paradisi on 3/30/20.
//  Copyright © 2020 Ignacio Paradisi. All rights reserved.
//

import Foundation

extension String {
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, bundle: bundle, value: "**\(self)**", comment: "")
    }
}
