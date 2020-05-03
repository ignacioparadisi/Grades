//
//  TermTableViewCellViewModel.swift
//  Grades
//
//  Created by Ignacio Paradisi on 3/29/20.
//  Copyright © 2020 Ignacio Paradisi. All rights reserved.
//

import UIKit

class TermTableViewCellViewModel: GradableRepresentable {
    // MARK: Properties
    /// Term to be displayed
    private let term: Term
    
    /// Name of the Term
    var text: String {
        term.name
    }
    
    /// Grade of the Term
    var grade: Float {
        term.grade
    }
    
    /// Status color of the Term
    var statusColor: UIColor {
        return UIColor.getColor(for: term)
    }
    
    /// Maximum grade of the Term
    var maxGrade: Float {
        return term.maxGrade
    }
    
    /// Minimum grade of the term
    var minGrade: Float {
        return term.minGrade
    }
    
    // MARK: Initializer
    init(term: Term) {
        self.term = term
    }
}
