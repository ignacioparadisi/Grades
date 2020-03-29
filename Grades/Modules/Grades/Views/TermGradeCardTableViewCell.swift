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
        Utilities.setupForMac { isMac in
            if isMac {
                cardView.anchor.edgesToSuperview(insets: UIEdgeInsets(top: 16, left: 16, bottom: -16, right: -16)).activate()
                return
            }
            cardView.anchor.edgesToSuperview().activate()
        }
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Preview
import SwiftUI

struct TermGradeCardTableViewCellPreview: PreviewProvider {
    static var previews: some View {
        ContainerView()
    }
    
    struct ContainerView: UIViewRepresentable {
        typealias UIViewType = TermGradeCardTableViewCell
        
        func makeUIView(context: UIViewRepresentableContext<TermGradeCardTableViewCellPreview.ContainerView>) -> TermGradeCardTableViewCell {
            TermGradeCardTableViewCell()
        }

        func updateUIView(_ uiView: TermGradeCardTableViewCell, context: UIViewRepresentableContext<TermGradeCardTableViewCellPreview.ContainerView>) {
        }
    }
}
