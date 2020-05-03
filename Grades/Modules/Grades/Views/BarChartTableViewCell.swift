//
//  BarChartTableViewCell.swift
//  Grades
//
//  Created by Ignacio Paradisi on 3/31/20.
//  Copyright © 2020 Ignacio Paradisi. All rights reserved.
//

import SwiftUI

class BarChartTableViewCell: UITableViewCell, ReusableView {
    
    let margin: CGFloat = 20
    var currentBarView = BarChartView()
    var currentView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        selectionStyle = .none
        contentView.addSubview(currentView)
    }
    
    func configure(with items: [Gradable]) {
        let barView = BarChartView(gradables: items)
        if currentBarView == barView { return }
        currentBarView = barView
        if let view = UIHostingController(rootView: BarChartView(gradables: items)).view {
            currentView.removeFromSuperview()
            currentView = view
            contentView.addSubview(view)
            view.anchor.edgesToSuperview(insets: UIEdgeInsets(top: margin, left: margin, bottom: -margin, right: -margin)).activate()
            view.backgroundColor = .clear
        }
    }
    
}

extension BarChartView: Equatable {
    static func == (lhs: BarChartView, rhs: BarChartView) -> Bool {
        return lhs.gradables.count == rhs.gradables.count
    }
}

struct BarChartView: View {
    var gradables: [Gradable] = []
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ForEach(0..<gradables.count, id: \.self) { index in
                BarView(gradable: self.gradables[index])
            }
        }
        .frame(maxWidth: .infinity, minHeight: 150)
    }
}

struct BarView: View {
    var gradable: Gradable
    var heightFactor: CGFloat {
        CGFloat(gradable.grade / gradable.maxGrade)
    }
    var body: some View {
        VStack(alignment: .leading) {
            Text(gradable.name)
                .font(.callout)
                .lineLimit(nil)
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 8)
                        .frame(height: 16)
                        .foregroundColor(Color(.systemGray5))
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: geometry.size.width * self.heightFactor, height: 16)
                        .foregroundColor(Color(UIColor.getColor(for: self.gradable)))
                    
                }
            }
        }
    }
}

struct BarChartTableViewCell_Previews: PreviewProvider {
    static var previews: some View {
        BarChartView(gradables: [
            Term(name: "Esto es un texto burda burda de largo para ver hasta donde llega", grade: 20, maxGrade: 20, minGrade: 10),
            Term(name: "Term 2", grade: 15, maxGrade: 20, minGrade: 10),
            Term(name: "Term 3", grade: 10, maxGrade: 20, minGrade: 10),
            Term(name: "Term 4", grade: 8, maxGrade: 20, minGrade: 10),
            Term(name: "Term 5", grade: 12, maxGrade: 20, minGrade: 10)
        ])
    }
}
