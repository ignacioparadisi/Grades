//
//  TermsViewController.swift
//  Grades
//
//  Created by Ignacio Paradisi on 3/29/20.
//  Copyright © 2020 Ignacio Paradisi. All rights reserved.
//

import UIKit

extension TermsViewController {
    enum Section: Int, CaseIterable {
        case grade
        #if targetEnvironment(macCatalyst)
        case home
        #endif
        case terms
    }
}

class TermsViewController: UIViewController {
    // MARK: Properties
    var viewModel = TermsViewControllerVM()
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        tableView = UITableView(frame: .zero, style: viewModel.tableViewStyle)
        navigationController?.navigationBar.prefersLargeTitles = true
        title = GradesStrings.terms.localized
        setupMacOS()
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.anchor.edgesToSuperview().activate()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        tableView.register(GradableTableViewCell.self)
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
            let cell = tableView.dequeueReusableCell(for: indexPath) as TermGradeCardTableViewCell
            return cell
        case .terms:
            guard let representable = viewModel.termCellRepresentable(for: indexPath) else { return UITableViewCell() }
            let cell = tableView.dequeueReusableCell(for: indexPath) as GradableTableViewCell
            cell.configure(with: representable)
            return cell
        #if targetEnvironment(macCatalyst)
        case .home:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
            cell.textLabel?.text = GradesStrings.home.localized
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
    
    #if targetEnvironment(macCatalyst)
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let section = Section(rawValue: section) else { return nil }
        if section != .terms { return nil }
        let view = UIView()
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline    )
        label.text = GradesStrings.terms.localized
        let button = UIButton()
        button.setImage(UIImage(systemName: Constants.Images.plus), for: .normal)
        view.addSubview(label)
        view.addSubview(button)
        label.anchor
            .topToSuperview()
            .bottomToSuperview()
            .leadingToSuperview(constant: 10)
            .activate()
        button.anchor
            .topToSuperview()
            .bottomToSuperview()
            .trailingToSuperview(constant: -16)
            .leading(to: label.trailingAnchor)
            .activate()
        return view
    }
    #endif
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let section = Section(rawValue: section) else { return 0.0 }
        if section != .terms { return 0.0 }
        return 44
    }
}

// MARK: - UITableViewDelegate
extension TermsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = Section(rawValue: indexPath.section) else { return }
        switch section {
        case .terms:
            showDetailViewController(UINavigationController(rootViewController: ViewController()), sender: nil)
        default:
            break
        }
    }
}
