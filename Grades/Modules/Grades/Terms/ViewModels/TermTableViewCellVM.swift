//
//  TermTableViewCellVM.swift
//  Grades
//
//  Created by Ignacio Paradisi on 3/29/20.
//  Copyright © 2020 Ignacio Paradisi. All rights reserved.
//

import UIKit

class TermTableViewCellVM: GradableRepresentable {
    // MARK: Properties
    private let term: Term
    var text: String {
        term.name
    }
    var grade: Float {
        term.grade
    }
    var statusColor: UIColor {
        return UIColor.getColor(for: term)
    }
    var maxGrade: Float {
        return term.maxGrade
    }
    var minGrade: Float {
        return term.minGrade
    }
    
    init(term: Term) {
        self.term = term
    }
}
