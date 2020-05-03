//
//  TermTableViewCell.swift
//  Grades
//
//  Created by Ignacio Paradisi on 3/29/20.
//  Copyright © 2020 Ignacio Paradisi. All rights reserved.
//

import SwiftUI

class TermTableViewCell: UITableViewCell, ReusableView {
    // MARK: Properties
    /// Vertical margin of content
    private let verticalMargin: CGFloat = 8
    /// Horizontal margin of content
    private let horizontalMargin: CGFloat = 20
    /// Current Ring View displayed
    private var currentRingView = UIView()
    /// Label for the name of the Term
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    /// Label for the years of the Term
    private var yearLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    // MARK: Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Functions
    /// Adds all the components to the view
    private func initialize() {
        if !isMacOS {
            accessoryType = .disclosureIndicator
        }
        addHoverGesture()
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(yearLabel)
        
        nameLabel.anchor
            .topToSuperview(constant: verticalMargin)
            .leadingToSuperview(constant: horizontalMargin)
            .activate()
        
        yearLabel.anchor
            .top(to: nameLabel.bottomAnchor)
            .bottomToSuperview(constant: -verticalMargin)
            .leading(to: nameLabel.leadingAnchor)
            .trailing(to: nameLabel.trailingAnchor)
            .activate()
    }

    /// Configures the cell with the gradable information and adds the semi-circle that is in the front
    /// - Parameter representable: Gradable to be displayed
    func configure(with representable: GradableRepresentable) {
        nameLabel.text = representable.text
        yearLabel.text = "2019 - 2020"
        let controller = UIHostingController(rootView: GradableRingView(gradable: representable, diameter: 44))
        if let view = controller.view {
            currentRingView.removeFromSuperview()
            currentRingView = view
            contentView.addSubview(currentRingView)
            currentRingView.backgroundColor = .clear
            currentRingView.anchor
                .top(greaterOrEqual: contentView.topAnchor, constant: verticalMargin)
                .trailingToSuperview(constant: -horizontalMargin)
                .bottom(lessOrEqual: contentView.bottomAnchor, constant: -verticalMargin)
                .centerYToSuperview()
                .activate()
            
            nameLabel.anchor.trailing(lessOrEqual: currentRingView.leadingAnchor, constant: -10).activate()
        }
    }

}
