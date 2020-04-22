//
//  GradeTableViewCell.swift
//  Grades
//
//  Created by Ignacio Paradisi on 3/31/20.
//  Copyright © 2020 Ignacio Paradisi. All rights reserved.
//

import UIKit

class GradeCardTableViewCell: UITableViewCell, ReusableView {
    let gradeCardView = GradeCardView()
    let maxGradeCardView = GradeCardView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(gradeCardView)
        contentView.addSubview(maxGradeCardView)
        gradeCardView
            .anchor
            .topToSuperview()
            .leadingToSuperview()
            .bottomToSuperview()
            .trailing(to: contentView.centerXAnchor, constant: -8)
            .activate()
        
        maxGradeCardView
            .anchor
            .topToSuperview()
            .trailingToSuperview()
            .bottomToSuperview()
            .leading(to: contentView.centerXAnchor, constant: 8)
            .activate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
