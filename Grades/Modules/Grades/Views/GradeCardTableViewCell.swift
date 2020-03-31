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
        contentView.addSubview(gradeCardView)
        contentView.addSubview(maxGradeCardView)
        #if targetEnvironment(macCatalyst)
        gradeCardView
            .anchor
            .topToSuperview(constant: 16)
            .leadingToSuperview(constant: 16)
            .bottomToSuperview(constant: -16)
            .trailing(to: contentView.centerXAnchor, constant: -8)
            .activate()
        
        maxGradeCardView
            .anchor
            .topToSuperview(constant: 16)
            .trailingToSuperview(constant: -16)
            .bottomToSuperview(constant: -16)
            .leading(to: contentView.centerXAnchor, constant: 8)
            .activate()
        #else
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
        #endif
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
