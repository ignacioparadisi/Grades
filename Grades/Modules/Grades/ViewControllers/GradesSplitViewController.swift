//
//  GradesSplitViewController.swift
//  Grades
//
//  Created by Ignacio Paradisi on 3/29/20.
//  Copyright © 2020 Ignacio Paradisi. All rights reserved.
//

import UIKit

class GradesSplitViewController: UISplitViewController {
    
    // MARK: - Initializer
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        let rootViewController = UINavigationController(rootViewController: TermsViewController())
        let vm = SubjectsViewControllerViewModel(term: Term(name: "Term 1", grade: 15, maxGrade: 20, minGrade: 10))
        let detailViewController = UINavigationController(rootViewController: SubjectsViewController(viewModel: vm))
        viewControllers = [rootViewController, detailViewController]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        primaryBackgroundStyle = .sidebar
        preferredDisplayMode = .allVisible
    }
    
}

extension GradesSplitViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}
