//
//  GradeCardView.swift
//  Grades
//
//  Created by Ignacio Paradisi on 3/7/20.
//  Copyright © 2020 Ignacio Paradisi. All rights reserved.
//

import UIKit

class GradeCardView: UIView {
    
    private let cardTopView = UIView()
    private let cardGradientView = GradientView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGreen
        layer.cornerRadius = 10
        
        addSubview(cardGradientView)
        cardGradientView.layer.cornerRadius = 6
        cardGradientView.anchor
            .edgesToSuperview(insets: UIEdgeInsets(top: 5, left: 5, bottom: -5, right: -5))
            .activate()
        
        cardGradientView.color = .systemGreen
        cardTopView.backgroundColor = .systemGreen
        
        cardGradientView.addSubview(cardTopView)
        cardTopView.layer.cornerRadius = 4
        cardTopView.anchor
            .edgesToSuperview(insets: UIEdgeInsets(top: 4, left: 4, bottom: -4, right: -4))
            .activate()
        
        // TODO: Delete this line after implementing the models
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        let containerView = UIView()
        let gradeLabel = createGradeLabel()
        let gradeTypeLabel = createGradeTypeLabel()
        let messageLabel = createMessageLabel()
        
        containerView.addSubview(gradeLabel)
        containerView.addSubview(gradeTypeLabel)
        containerView.addSubview(messageLabel)
        
        gradeLabel.anchor
            .topToSuperview()
            .leadingToSuperview()
            .trailingToSuperview()
            .activate()
        gradeTypeLabel.anchor
            .top(to: gradeLabel.bottomAnchor)
            .leadingToSuperview()
            .trailingToSuperview()
            .activate()
        messageLabel.anchor
            .top(to: gradeTypeLabel.bottomAnchor)
            .leadingToSuperview()
            .trailingToSuperview()
            .bottomToSuperview()
            .activate()
        
        cardTopView.addSubview(containerView)
        containerView.anchor
            .edgesToSuperview(insets: UIEdgeInsets(top: 10, left: 16, bottom: -20, right: -16))
            .activate()
        
    }
    
    private func createGradeLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 80.0)
        label.text = "20"
        return label
    }
    
    private func createGradeTypeLabel() -> UILabel {
        let label = UILabel()
        label.text = "Grade"
        return label
    }
    
    private func createMessageLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        label.text = "You are doing great!"
        return label
    }
    
}
