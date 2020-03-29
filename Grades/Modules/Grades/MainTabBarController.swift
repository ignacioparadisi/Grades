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
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        gradesViewController.tabBarItem = UITabBarItem(title: "Grades", image: UIImage(systemName: "star.fill"), tag: 1)
        viewControllers = [homeViewController, gradesViewController]
    }

}
