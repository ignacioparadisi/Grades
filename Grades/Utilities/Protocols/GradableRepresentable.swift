//
//  GradableRepresentable.swift
//  Grades
//
//  Created by Ignacio Paradisi on 5/1/20.
//  Copyright © 2020 Ignacio Paradisi. All rights reserved.
//

import UIKit

/// States the information that a View Model for `TermTableViewCell` should have
protocol GradableRepresentable {
    var text: String { get }
    var grade: Float { get }
    var maxGrade: Float { get }
    var minGrade: Float { get }
    var statusColor: UIColor { get }
}
