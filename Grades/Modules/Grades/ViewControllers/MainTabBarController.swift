//
//  MainTabBarController.swift
//  Grades
//
//  Created by Ignacio Paradisi on 3/29/20.
//  Copyright © 2020 Ignacio Paradisi. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    let gradesViewController = GradesSplitViewController()
    let homeViewController = HomeSplitViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewController.tabBarItem = UITabBarItem(title: GradesStrings.home.localized,
                                                     image: UIImage(systemName: Constants.Images.houseFill), tag: 0)
        gradesViewController.tabBarItem = UITabBarItem(title: GradesStrings.grades.localized,
                                                       image: UIImage(systemName: Constants.Images.starFill), tag: 1)
        viewControllers = [homeViewController, gradesViewController]
    }       

}
