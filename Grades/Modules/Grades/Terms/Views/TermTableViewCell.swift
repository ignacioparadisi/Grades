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
}

class TermTableViewCell: UITableViewCell, ReusableView {

    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    func configure(with representable: GradableTableViewCellRepresentable) {
        textLabel?.text = representable.text
        
        let hoverGesture = UIHoverGestureRecognizer(target: self, action: #selector(setHoverColor(_:)))
        contentView.addGestureRecognizer(hoverGesture)
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
    
}
