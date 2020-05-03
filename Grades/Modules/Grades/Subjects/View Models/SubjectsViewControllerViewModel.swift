//
//  SubjectsViewControllerVM.swift
//  Grades
//
//  Created by Ignacio Paradisi on 3/31/20.
//  Copyright © 2020 Ignacio Paradisi. All rights reserved.
//

import Foundation

class SubjectsViewControllerViewModel {
    // MARK: Properties
    /// Sections for the Table View
    typealias Section = SubjectsViewController.Section
    /// Term where the subjects belong
    let term: Term
    /// Subjects to be displayed
    var subjects: [Term] = [
        Term(name: "Esto es un texto burda burda de largo para ver hasta donde llega", grade: 20, maxGrade: 20, minGrade: 10),
        Term(name: "Term 2", grade: 15, maxGrade: 20, minGrade: 10),
        Term(name: "Term 3", grade: 10, maxGrade: 20, minGrade: 10),
        Term(name: "Term 4", grade: 8, maxGrade: 20, minGrade: 10),
        Term(name: "Term 5", grade: 12, maxGrade: 20, minGrade: 10),
        Term(name: "Esto es un texto burda burda de largo para ver hasta donde llega", grade: 20, maxGrade: 20, minGrade: 10),
        Term(name: "Term 2", grade: 15, maxGrade: 20, minGrade: 10),
        Term(name: "Term 3", grade: 10, maxGrade: 20, minGrade: 10),
        Term(name: "Term 4", grade: 8, maxGrade: 20, minGrade: 10),
        Term(name: "Term 5", grade: 12, maxGrade: 20, minGrade: 10)
    ]
    private var termsVM: [GradableRepresentable] = []
    /// Title for the View Controller
    var title: String {
        term.name
    }
    /// Number of sections for the Table View
    var numberOfSections: Int {
        return Section.allCases.count
    }
    
    // MARK: Initializer
    init(term: Term) {
        self.term = term
        subjects.forEach { term in
            termsVM.append(TermTableViewCellViewModel(term: term))
        }
    }
    
    // MARK: Functions
    
    /// Number of rows for a specific sections of the Table View
    /// - Parameter section: Section of the Table View
    /// - Returns: Number of rows for the Table View
    func numberOfRows(in section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        switch section {
            #if targetEnvironment(macCatalyst)
        case .title:
            return 1
            #endif
        case .grade:
            return 1
        case .subjects:
            return subjects.count
        }
    }
    
    /// <#Description#>
    /// - Parameter indexPath: <#indexPath description#>
    /// - Returns: <#description#>
    func termCellRepresentable(for indexPath: IndexPath) -> GradableRepresentable? {
        let index = indexPath.row
        guard index >= 0, index < subjects.count else { return nil }
        return termsVM[index]
    }
}
