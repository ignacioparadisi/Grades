//
//  TermTableViewCell.swift
//  Grades
//
//  Created by Ignacio Paradisi on 3/29/20.
//  Copyright © 2020 Ignacio Paradisi. All rights reserved.
//

import UIKit

protocol GradableTableViewCellRepresentable {
    var name: String { get set }
    var grade: Float { get set }
}

class TermTableViewCell: UITableViewCell, ReusableView {

    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(with representable: GradableTableViewCellRepresentable) {
        textLabel?.text = representable.name
    }
    
}
