//
//  GradableRingView.swift
//  Grades
//
//  Created by Ignacio Paradisi on 4/22/20.
//  Copyright © 2020 Ignacio Paradisi. All rights reserved.
//

import SwiftUI

struct GradableRingView: View {
    /// The angle where the stoke ends after calculating it based on the grade
     @State private var gradableEndAngle: CGFloat = 0.0
    /// Gradable to represent in the ring
    var gradable: GradableRepresentable
    /// Diameter of the ring
    var diameter: CGFloat = 44
    /// The start angle of the grade ring
    private let startAngle: CGFloat = 0.0
    /// The end angle of the grade ring
    private let endAngle: CGFloat = 0.66
    /// Line width of the stoke
    private let lineWidth: CGFloat = 7
    /// Multiplier for the font size and line width depending on the diameter of the ring
    private var sizeMultiplier: CGFloat {
        return diameter / 44
    }
    private var animation: Animation? {
        return  Animation.easeInOut(duration: 0.7)
    }
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: self.startAngle, to: self.endAngle)
                .stroke(Color(.black).opacity(0.15),
                        style: StrokeStyle(lineWidth: self.lineWidth * self.sizeMultiplier,
                                           lineCap: .round,
                                           lineJoin: .round,
                                           miterLimit: 0,
                                           dash: [],
                                           dashPhase: 0)
            )
                .frame(width: diameter, height: diameter)
                .rotationEffect(.degrees(-210))
            
            Circle()
                .trim(from: self.startAngle, to: self.gradableEndAngle)
                .stroke(Color(UIColor.getColor(for: self.gradable)),
                        style: StrokeStyle(lineWidth: self.lineWidth *  self.sizeMultiplier,
                                           lineCap: .round,
                                           lineJoin: .round,
                                           miterLimit: 0,
                                           dash: [],
                                           dashPhase: 0)
            )
                .frame(width: diameter, height: diameter)
                .rotationEffect(Angle(degrees: -210))
                .onAppear {
                    self.animateRing(self.gradable)
                }
            
            Text("\(Int(self.gradable.grade))")
                .font(.system(size: 17 * self.sizeMultiplier))
        }
        .padding(.top, 9)
    }
    
    func animateRing(_ gradable: GradableRepresentable) {
        withAnimation(animation) {
            self.gradableEndAngle = (CGFloat(self.gradable.grade) * self.endAngle) / CGFloat(self.gradable.maxGrade)
        }
    }
}

struct GradableRingView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = TermTableViewCellViewModel(term: Term(name: "Term", grade: 16, maxGrade: 20, minGrade: 10))
        return GradableRingView(gradable: viewModel)
    }
}
