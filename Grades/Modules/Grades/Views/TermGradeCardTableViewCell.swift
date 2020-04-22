//
//  TermGradeCardTableViewCell.swift
//  Grades
//
//  Created by Ignacio Paradisi on 3/6/20.
//  Copyright © 2020 Ignacio Paradisi. All rights reserved.
//

import UIKit

class TermGradeCardTableViewCell: UITableViewCell, ReusableView {
    
    let cardView = GradeCardView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        addSubview(cardView)
        if isMacOS {
            cardView.anchor.edgesToSuperview(insets: UIEdgeInsets(top: 16, left: 16, bottom: -16, right: -16)).activate()
            return
        }
        cardView.anchor.edgesToSuperview().activate()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
