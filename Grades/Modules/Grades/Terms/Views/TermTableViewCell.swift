//
//  TermTableViewCell.swift
//  Grades
//
//  Created by Ignacio Paradisi on 3/29/20.
//  Copyright © 2020 Ignacio Paradisi. All rights reserved.
//

import UIKit

protocol GradableRepresentable {
    var text: String { get }
    var grade: Float { get }
    var maxGrade: Float { get }
    var minGrade: Float { get }
    var statusColor: UIColor { get }
}

class TermTableViewCell: UITableViewCell, ReusableView {
    // MARK: Properties
    private let progressRing = ProgressRingView(radius: 25)
    
    // MARK: Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        addSubview(progressRing)
        progressRing.anchor
            .topToSuperview(constant: 4)
            .bottomToSuperview(constant: -4)
            .trailingToSuperview(constant: -16)
            .activate()
        imageView?.layer.cornerRadius = 10
        imageView?.layer.masksToBounds = true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    func configure(with representable: GradableRepresentable) {
        progressRing.configure(with: representable)
        textLabel?.text = representable.text
        detailTextLabel?.textColor = .secondaryLabel
        detailTextLabel?.text = "Mar. 2019 - Sep. 2020"
        
        #if targetEnvironment(macCatalyst)
        let hoverGesture = UIHoverGestureRecognizer(target: self, action: #selector(setHoverColor(_:)))
        contentView.addGestureRecognizer(hoverGesture)
        #endif
    }
    
    func image(from view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            view.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
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
