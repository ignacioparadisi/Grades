//
//  TermsViewController.swift
//  Grades
//
//  Created by Ignacio Paradisi on 3/29/20.
//  Copyright © 2020 Ignacio Paradisi. All rights reserved.
//

import UIKit

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
        setupMacOS()
        title = "Terms"
        view.addSubview(tableView)
        tableView.anchor.edgesToSuperview().activate()
        tableView.register(TermTableViewCell.self)
        tableView.register(TermGradeCardTableViewCell.self)
        tableView.dataSource = self
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
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        }
        return mockData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(for: indexPath) as TermGradeCardTableViewCell
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(for: indexPath) as TermTableViewCell
            cell.textLabel?.text = "Notifications"
            return cell
        }
        let cell = tableView.dequeueReusableCell(for: indexPath) as TermTableViewCell
        cell.configure(with: TermTableViewCellVM(term: mockData[indexPath.row]))
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 2 {
            return "Terms"
        } else if section == 1 {
            return "Notifications"
        }
        return nil
    }
}
