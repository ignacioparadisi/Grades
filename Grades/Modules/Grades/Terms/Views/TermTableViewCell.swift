//
//  TermTableViewCell.swift
//  Grades
//
//  Created by Ignacio Paradisi on 3/29/20.
//  Copyright © 2020 Ignacio Paradisi. All rights reserved.
//

import UIKit

protocol GradableTableViewCellRepresentable {
    var text: String { get }
    var grade: Float { get }
    var statusColor: UIColor { get }
}

class TermTableViewCell: UITableViewCell, ReusableView {
    // MARK: Properties
    private let statusBar: UIView = UIView()
    private let gradeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    // MARK: Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        addSubview(statusBar)
        statusBar.anchor
            .topToSuperview()
            .leadingToSuperview()
            .bottomToSuperview()
            .width(constant: 5)
            .activate()
        setupGradeLabel()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    func configure(with representable: GradableTableViewCellRepresentable) {
        textLabel?.text = representable.text
        detailTextLabel?.textColor = .secondaryLabel
        detailTextLabel?.text = "Mar. 2019 - Sep. 2020"
        statusBar.backgroundColor = representable.statusColor
        gradeLabel.text = "\(representable.grade)"
        #if targetEnvironment(macCatalyst)
        let hoverGesture = UIHoverGestureRecognizer(target: self, action: #selector(setHoverColor(_:)))
        contentView.addGestureRecognizer(hoverGesture)
        #endif
    }
    
    @objc private func setHoverColor(_ gesture: UIHoverGestureRecognizer) {
        switch gesture.state {
        case .began, .changed:
            backgroundColor = .systemGray2
        case .ended:
            backgroundColor = nil
        default:
            break
        }
    }
    
    private func setupGradeLabel() {
        // Could add vibrancy to `labelBackgroundView`
        let labelBackgroundView = UIView()
        let color = UIColor.systemGray3.withAlphaComponent(0.5)
        labelBackgroundView.backgroundColor = color
        labelBackgroundView.layer.cornerRadius = 25
        labelBackgroundView.layer.masksToBounds = false
        addSubview(labelBackgroundView)
        labelBackgroundView.anchor
            .topToSuperview(constant: 4)
            .bottomToSuperview(constant: -4)
            .trailingToSuperview(constant: -16)
            .centerYToSuperview()
            .height(constant: 50)
            .width(to: labelBackgroundView.heightAnchor)
            .activate()
        
        labelBackgroundView.addSubview(gradeLabel)
        gradeLabel.anchor.edgesToSuperview().activate()
    }
    
}
