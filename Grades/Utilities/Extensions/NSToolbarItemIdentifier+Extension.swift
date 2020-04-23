//
//  NSToolbarIdentifier+Extension.swift
//  Grades
//
//  Created by Ignacio Paradisi on 3/29/20.
//  Copyright © 2020 Ignacio Paradisi. All rights reserved.
//

import UIKit

#if targetEnvironment(macCatalyst)
extension NSToolbarItem.Identifier {
    static let title = NSToolbarItem.Identifier("title")
    static let add = NSToolbarItem.Identifier("add")
    static let back = NSToolbarItem.Identifier("back")
}
#endif
