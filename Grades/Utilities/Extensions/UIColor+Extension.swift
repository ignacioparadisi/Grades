//
//  UIColor+Extension.swift
//  Grades
//
//  Created by Ignacio Paradisi on 3/6/20.
//  Copyright © 2020 Ignacio Paradisi. All rights reserved.
//

import UIKit

extension UIColor {
    
    /// Creates a color lighter than self
    /// - Parameter percentage: Percentage of lighness
    /// - Returns: Color lighter than self
    func lighter(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: abs(percentage) )
    }

    /// Creates a color darker than self
    /// - Parameter percentage: Percentage of darkness
    /// - Returns: Color darker than self
    func darker(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: -1 * abs(percentage) )
    }

    func adjust(by percentage: CGFloat = 30.0) -> UIColor? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: min(red + percentage/100, 1.0),
                           green: min(green + percentage/100, 1.0),
                           blue: min(blue + percentage/100, 1.0),
                           alpha: alpha)
        } else {
            return nil
        }
    }
}
