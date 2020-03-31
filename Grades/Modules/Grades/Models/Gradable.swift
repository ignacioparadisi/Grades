//
//  Gradable.swift
//  Grades
//
//  Created by Ignacio Paradisi on 3/29/20.
//  Copyright © 2020 Ignacio Paradisi. All rights reserved.
//

import Foundation

protocol Gradable {
    var name: String { get set }
    var grade: Float { get set }
    var maxGrade: Float { get set }
    var minGrade: Float { get set }
}
