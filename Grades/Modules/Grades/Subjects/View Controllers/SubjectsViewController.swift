//
//  SubjectsViewController.swift
//  Grades
//
//  Created by Ignacio Paradisi on 3/31/20.
//  Copyright © 2020 Ignacio Paradisi. All rights reserved.
//

import UIKit

extension SubjectsViewController {
    enum Section: Int, CaseIterable {
        case grade
        case chart
        case subjects
    }
}

class SubjectsViewController: UIViewController {
    // MARK: Properties
    var viewModel = SubjectsViewControllerVM()
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        tableView = UITableView(frame: .zero, style: .insetGrouped)
        navigationController?.navigationBar.prefersLargeTitles = true
        title = GradesStrings.terms.localized
        setupMacOS()
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.anchor.edgesToSuperview().activate()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        tableView.register(GradableTableViewCell.self)
        tableView.register(GradeCardTableViewCell.self)
        tableView.register(BarChartTableViewCell.self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    func setupMacOS() {
        #if targetEnvironment(macCatalyst)
        navigationController?.navigationBar.isHidden = true
        #endif
    }

}

// MARK: - UITableViewDataSource
extension SubjectsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else { return UITableViewCell() }
        switch section {
        case .grade:
            let cell = tableView.dequeueReusableCell(for: indexPath) as GradeCardTableViewCell
            return cell
        case .chart:
            let cell = tableView.dequeueReusableCell(for: indexPath) as BarChartTableViewCell
            cell.configure(with: [
                Term(name: "Esto es un texto burda burda de largo para ver hasta donde llega", grade: 20, maxGrade: 20, minGrade: 10),
                Term(name: "Term 2", grade: 15, maxGrade: 20, minGrade: 10),
                Term(name: "Term 3", grade: 10, maxGrade: 20, minGrade: 10),
                Term(name: "Term 4", grade: 8, maxGrade: 20, minGrade: 10),
                Term(name: "Term 5", grade: 12, maxGrade: 20, minGrade: 10)
            ])
            return cell
        case .subjects:
            guard var representable = viewModel.termCellRepresentable(for: indexPath) else { return UITableViewCell() }
            let cell = tableView.dequeueReusableCell(for: indexPath) as GradableTableViewCell
            cell.configure(with: &representable)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = Section(rawValue: section) else { return nil }
        switch section {
        case .subjects:
            return "Subjects"
        default:
            return nil
        }
    }
}
