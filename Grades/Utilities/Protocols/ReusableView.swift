//
//  ReusableView.swift
//  Grades
//
//  Created by Ignacio Paradisi on 3/29/20.
//  Copyright © 2020 Ignacio Paradisi. All rights reserved.
//

import UIKit

/// Adds a reuse identifier to the View
protocol ReusableView: class {
    static var reusableIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var reusableIdentifier: String {
        return String(describing: self)
    }
}
