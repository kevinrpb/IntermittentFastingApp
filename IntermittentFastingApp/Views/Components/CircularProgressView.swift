//
//  CircularProgressView.swift
//  IntermittentFastingApp
//
//  Created by Romero Peces Barba, Kevin on 8/1/23.
//

import SwiftUI

struct CircularProgressView: View {
    // MARK: Class variables
    private static let defaultStrokeStyle: LinearGradient = .init(
        gradient: Gradient(colors: [Color.purple, Color.indigo]),
        startPoint: .top,
        endPoint: .bottom
    )
    private static let defaultLineWidth: CGFloat = 25
    private static let defaultLineCap: CGLineCap = .round
    
    // MARK: Instance variables
    @Binding var progress: Double

    let strokeStyle: AnyShapeStyle
    let lineWidth: CGFloat
    let lineCap: CGLineCap
    
    private var adjustedProgress: CGFloat {
        CGFloat(max(0, min(1, progress)))
    }
    
    // MARK: Init
    init(
        progress: Binding<Double>,
        strokeStyle: LinearGradient = Self.defaultStrokeStyle,
        lineWidth: CGFloat = Self.defaultLineWidth,
        lineCap: CGLineCap = Self.defaultLineCap
    ) {
        self._progress = progress
        self.strokeStyle = AnyShapeStyle(strokeStyle)
        self.lineWidth = lineWidth
        self.lineCap = lineCap
    }
    
    init(
        progress: Binding<Double>,
        strokeStyle: AnyShapeStyle,
        lineWidth: CGFloat = Self.defaultLineWidth,
        lineCap: CGLineCap = Self.defaultLineCap
    ) {
        self._progress = progress
        self.strokeStyle = strokeStyle
        self.lineWidth = lineWidth
        self.lineCap = lineCap
    }
    
    // MARK: Body
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: lineWidth)
                .foregroundColor(Color.secondary.opacity(0.3))
            
            Circle()
                .trim(
                    from: 0.0,
                    to: adjustedProgress
                )
                .stroke(strokeStyle, style: StrokeStyle(
                    lineWidth: lineWidth,
                    lineCap: lineCap,
                    lineJoin: .round)
                )
                .rotationEffect(.init(degrees: 270.0))
                .animation(.linear, value: progress)
        }
        .padding()
    }
}

struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressView(progress: .constant(0.2))
    }
}
