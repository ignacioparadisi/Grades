//
//  TermsViewControllerViewModel.swift
//  Grades
//
//  Created by Ignacio Paradisi on 3/30/20.
//  Copyright © 2020 Ignacio Paradisi. All rights reserved.
//

import UIKit

class TermsViewControllerViewModel {
    // MARK: Properties
    typealias Section = TermsViewController.Section
    private var terms: [Term] = [
        Term(name: "Esto es un texto burda burda de largo para ver hasta donde llega", grade: 20, maxGrade: 20, minGrade: 10),
        Term(name: "Term 2", grade: 15, maxGrade: 20, minGrade: 10),
        Term(name: "Term 3", grade: 10, maxGrade: 20, minGrade: 10),
        Term(name: "Term 4", grade: 8, maxGrade: 20, minGrade: 10),
        Term(name: "Term 5", grade: 12, maxGrade: 20, minGrade: 10)
    ]
    private var termsVM: [GradableRepresentable] = []
    var tableViewStyle: UITableView.Style {
        #if targetEnvironment(macCatalyst)
        return .plain
        #endif
        return .insetGrouped
    }
    var numberOfSections: Int {
        return Section.allCases.count
    }
    init() {
        terms.forEach { term in
            termsVM.append(TermTableViewCellViewModel(term: term))
        }
    }
    func numberOfRows(in section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        switch section {
        case .grade:
            return 1
        case .terms:
            return terms.count
        #if targetEnvironment(macCatalyst)
        case .home:
            return 1
        #endif
        }
    }
    func termCellRepresentable(for indexPath: IndexPath) -> GradableRepresentable? {
        let index = indexPath.row
        guard index >= 0, index < terms.count else { return nil }
        return termsVM[index]
    }
    func subjectViewModel(for indexPath: IndexPath) -> SubjectsViewControllerViewModel {
        let term = terms[indexPath.row]
        return SubjectsViewControllerViewModel(term: term)
    }
}
