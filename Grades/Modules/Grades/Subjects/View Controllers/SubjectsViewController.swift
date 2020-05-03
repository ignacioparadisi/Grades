//
//  SubjectsViewController.swift
//  Grades
//
//  Created by Ignacio Paradisi on 3/31/20.
//  Copyright © 2020 Ignacio Paradisi. All rights reserved.
//

import UIKit
import SwiftUI

extension SubjectsViewController {
    enum Section: Int, CaseIterable {
        #if targetEnvironment(macCatalyst)
        case title
        #endif
        case grade
        case subjects
    }
}

class SubjectsViewController: UIViewController {
    // MARK: Properties
    var viewModel: SubjectsViewControllerViewModel
    var tableView: UITableView!
    
    init(viewModel: SubjectsViewControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        tableView = UITableView(frame: .zero, style: .insetGrouped)
        view.backgroundColor = .systemGroupedBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        title = GradesStrings.terms.localized
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.anchor.edgesToSuperview().activate()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        tableView.register(TermTableViewCell.self)
        tableView.register(GradeCardTableViewCell.self)
        setupMacOS()
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func setupMacOS() {
        #if targetEnvironment(macCatalyst)
        navigationController?.navigationBar.isHidden = true
        #endif
    }
    
//    func setTableHeaderView() {
//        let headerView = UIView()
//        let blurEffect = UIBlurEffect(style: .prominent)
//        let blurView = UIVisualEffectView(effect: blurEffect)
//        let button = ToolbarButton()
//        button.setImage(named: Constants.Images.chevronLeft)
//        headerView.addSubview(blurView)
//        blurView.anchor.edgesToSuperview().activate()
//        headerView.addSubview(button)
//        button.anchor.leadingToSuperview(constant: 16).bottomToSuperview(constant: -16).width(constant: 34).height(constant: 28).activate()
//        view.addSubview(headerView)
//        headerView.anchor.topToSuperview().leadingToSuperview().trailingToSuperview().height(constant: 110).activate()
//
//        tableView.contentInset = UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)
//        tableView.scrollIndicatorInsets = UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)
//    }
}

class ToolbarButton: UIButton {
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                backgroundColor = .systemGray2
            } else {
                backgroundColor = .systemGray3
            }
        }
    }
    init() {
        super.init(frame: .zero)
        layer.cornerRadius = 5
        layer.masksToBounds = true
        backgroundColor = .systemGray2
        tintColor = .label
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImage(named: String) {
        setImage(UIImage(systemName: named, withConfiguration: UIImage.SymbolConfiguration(weight: .semibold)), for: .normal)
        setImage(UIImage(systemName: named, withConfiguration: UIImage.SymbolConfiguration(weight: .semibold)), for: .highlighted)
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
        #if targetEnvironment(macCatalyst)
        case .title:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
            cell.backgroundColor = .none
            cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .largeTitle)
            cell.textLabel?.font = UIFont.systemFont(ofSize: cell.textLabel?.font.pointSize ?? 34, weight: .bold)
            cell.textLabel?.text = viewModel.title
            cell.textLabel?.anchor.edgesToSuperview(insets: UIEdgeInsets(top: 26, left: 0, bottom: 0, right: 0)).activate()
            return cell
        #endif
        case .grade:
            let cell = tableView.dequeueReusableCell(for: indexPath) as GradeCardTableViewCell
            return cell
        case .subjects:
            guard var representable = viewModel.termCellRepresentable(for: indexPath) else { return UITableViewCell() }
            let cell = tableView.dequeueReusableCell(for: indexPath) as TermTableViewCell
            cell.configure(with: representable)
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

extension SubjectsViewController: UITableViewDelegate {
}
