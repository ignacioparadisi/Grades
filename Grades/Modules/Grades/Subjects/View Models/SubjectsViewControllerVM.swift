//
//  SubjectsViewControllerVM.swift
//  Grades
//
//  Created by Ignacio Paradisi on 3/31/20.
//  Copyright © 2020 Ignacio Paradisi. All rights reserved.
//

import Foundation

class SubjectsViewControllerVM {
    // MARK: Properties
       typealias Section = SubjectsViewController.Section
       private var subjects: [Term] = [
           Term(name: "Esto es un texto burda burda de largo para ver hasta donde llega", grade: 20, maxGrade: 20, minGrade: 10),
           Term(name: "Term 2", grade: 15, maxGrade: 20, minGrade: 10),
           Term(name: "Term 3", grade: 10, maxGrade: 20, minGrade: 10),
           Term(name: "Term 4", grade: 8, maxGrade: 20, minGrade: 10),
           Term(name: "Term 5", grade: 12, maxGrade: 20, minGrade: 10)
       ]
       private var termsVM: [GradableRepresentable] = []
       var numberOfSections: Int {
           return Section.allCases.count
       }
       init() {
           subjects.forEach { term in
               termsVM.append(TermTableViewCellVM(term: term))
           }
       }
       func numberOfRows(in section: Int) -> Int {
           guard let section = Section(rawValue: section) else { return 0 }
           switch section {
           case .grade:
               return 1
           case .chart:
            return 1
           case .subjects:
               return subjects.count
           }
       }
       func termCellRepresentable(for indexPath: IndexPath) -> GradableRepresentable? {
           let index = indexPath.row
           guard index >= 0, index < subjects.count else { return nil }
           return termsVM[index]
       }
}
