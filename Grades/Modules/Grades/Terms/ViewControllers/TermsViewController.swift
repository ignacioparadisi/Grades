//
//  TermsViewController.swift
//  Grades
//
//  Created by Ignacio Paradisi on 3/29/20.
//  Copyright © 2020 Ignacio Paradisi. All rights reserved.
//

import UIKit

extension TermsViewController {
    private enum Section: Int, CaseIterable {
        case grade
        #if targetEnvironment(macCatalyst)
        case home
        #endif
        case terms
    }
}

class TermsViewController: UIViewController {
    var tableView: UITableView = {
        var tableView: UITableView!
        #if targetEnvironment(macCatalyst)
        tableView = UITableView()
        #else
        tableView = UITableView(frame: .zero, style: .insetGrouped)
        #endif
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Terms"
        setupMacOS()
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.anchor.edgesToSuperview().activate()
        tableView.register(TermTableViewCell.self)
        tableView.register(TermGradeCardTableViewCell.self)
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
extension TermsViewController: UITableViewDataSource {
    var mockData: [Term] {
        return [
            Term(name: "Term 1", grade: 20, maxGrade: 20, minGrade: 10),
            Term(name: "Term 2", grade: 15, maxGrade: 20, minGrade: 10),
            Term(name: "Term 3", grade: 10, maxGrade: 20, minGrade: 10),
            Term(name: "Term 4", grade: 8, maxGrade: 20, minGrade: 10),
            Term(name: "Term 5", grade: 12, maxGrade: 20, minGrade: 10)
        ]
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        switch section {
        case .grade:
            return 1
        case .terms:
            return mockData.count
        #if targetEnvironment(macCatalyst)
        case .home:
            return 1
        #endif
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else { return UITableViewCell() }
        switch section {
        case .grade:
            let cell = tableView.dequeueReusableCell(for: indexPath) as TermGradeCardTableViewCell
            return cell
        case .terms:
            let cell = tableView.dequeueReusableCell(for: indexPath) as TermTableViewCell
            cell.configure(with: TermTableViewCellVM(term: mockData[indexPath.row]))
            return cell
        #if targetEnvironment(macCatalyst)
        case .home:
            let cell = tableView.dequeueReusableCell(for: indexPath) as TermTableViewCell
            cell.textLabel?.text = "Home"
            return cell
        #endif
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = Section(rawValue: section) else { return nil }
        switch section {
        case .terms:
            return "Terms"
        default:
            return nil
        }
    }
}

// MARK: - UITableViewDelegate
extension TermsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showDetailViewController(ViewController(), sender: nil)
    }
}
