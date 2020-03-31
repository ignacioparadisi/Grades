//
//  TermTableViewCell.swift
//  Grades
//
//  Created by Ignacio Paradisi on 3/29/20.
//  Copyright © 2020 Ignacio Paradisi. All rights reserved.
//

import SwiftUI

protocol GradableRepresentable {
    var text: String { get }
    var grade: Float { get }
    var maxGrade: Float { get }
    var minGrade: Float { get }
    var statusColor: UIColor { get }
    var didAppear: Bool { get set }
}

extension GradableRepresentable {
    mutating func toggleAppear() {
        didAppear.toggle()
    }
}

class GradableTableViewCell: UITableViewCell, ReusableView {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Adds all the components to the view
    private func initialize() {
        #if targetEnvironment(macCatalyst)
        let hoverGesture = UIHoverGestureRecognizer(target: self, action: #selector(setHoverColor(_:)))
        contentView.addGestureRecognizer(hoverGesture)
        #endif
    }
    
    /// Configures the cell with the gradable information and adds the semi-circle that is in the front
    ///
    /// - Parameter gradable: Gradable to be displayed
    func configure(with representable: inout GradableRepresentable) {
        if let view = UIHostingController(rootView: GradableView(representable: representable)).view {
            contentView.subviews.last?.removeFromSuperview()
            contentView.addSubview(view)
            view.backgroundColor = .clear
            view.anchor.edgesToSuperview(insets: UIEdgeInsets(top: 8, left: 20, bottom: -8, right: -20)).activate()
        }
        representable.didAppear = false

    }
    
    @objc private func setHoverColor(_ gesture: UIHoverGestureRecognizer) {
        switch gesture.state {
        case .began, .changed:
            contentView.backgroundColor = .systemGray2
        case .ended:
            contentView.backgroundColor = .clear
        default:
            break
        }
    }

}

struct GradableView: View {
    var representable: GradableRepresentable
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy - h:mma"
        return formatter
    }()
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(representable.text)
                    .lineLimit(2)
                Text("2019 - 2020")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.top, 2)
//                HStack{
//                    Divider()
//                        .frame(width: 2)
//                        .background(getDividerColor())
//
//                    Text(dateFormatter.string(from: assignment.deadline))
//                        .font(.body)
//                        .foregroundColor(getDateTextColor())
//                    Spacer()
//                }
            }
            Spacer()
            GradableCharView(gradable: representable).frame(width: 52, height: 52)
        }
    }
    
//    private func getDividerColor() -> Color {
//        return (representable.deadline >= Date()) ? Color(UIColor.accentColor!) : Color(.systemGray3)
//    }
//    
//    private func getDateTextColor() -> Color {
//        return (representable.deadline >= Date()) ? Color(.label) : Color(.secondaryLabel)
//    }
}

struct GradableCharView: View {
    var gradable: GradableRepresentable
    /// The start angle of the grade graph
    private let startAngle: CGFloat = 0.0
    /// The end angle of the grade graph
    private let endAngle: CGFloat = 0.66
    private let lineWidth: CGFloat = 7
    private var animation: Animation? {
        return !self.gradable.didAppear ? Animation.easeInOut(duration: 0.7) : .none
    }
    @State private var gradableEndAngle: CGFloat = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Circle()
                    .trim(from: self.startAngle, to: self.endAngle)
                    .stroke(Color(.systemGray5), style: StrokeStyle(lineWidth: self.lineWidth,
                                                                    lineCap: .round,
                                                                    lineJoin: .round,
                                                                    miterLimit: 0,
                                                                    dash: [],
                                                                    dashPhase: 0))
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .rotationEffect(Angle(degrees: -210))
                
                Circle()
                    .trim(from: self.startAngle, to: self.gradableEndAngle)
                    .stroke(Color(UIColor.getColor(for: self.gradable)), style: StrokeStyle(lineWidth: self.lineWidth,
                                                                                            lineCap: .round,
                                                                                            lineJoin: .round,
                                                                                            miterLimit: 0,
                                                                                            dash: [],
                                                                                            dashPhase: 0))
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .rotationEffect(Angle(degrees: -210))
                    .onAppear {
                        self.animateRing(self.gradable)
                }
                
                Text("\(Int(self.gradable.grade))")
            }
        }
        .padding(.top, 9)
    }
    
    func animateRing(_ gradable: GradableRepresentable) {
        withAnimation(animation) {
            self.gradableEndAngle = (CGFloat(self.gradable.grade) * self.endAngle) / CGFloat(self.gradable.maxGrade)
        }
    }
}
