//
//  CircularProgressView.swift
//  IntermittentFastingApp
//
//  Created by Romero Peces Barba, Kevin on 8/1/23.
//

import SwiftUI

// MARK: Class variables
fileprivate let defaultStrokeStyle: LinearGradient = .init(
    gradient: Gradient(colors: [Color.purple, Color.indigo]),
    startPoint: .top,
    endPoint: .bottom
)
fileprivate let defaultLineWidth: CGFloat = 25
fileprivate let defaultLineCap: CGLineCap = .round

struct CircularProgressView<InsideContent: View>: View {
    
    // MARK: Instance variables
    @Binding var progress: Double

    let strokeStyle: AnyShapeStyle
    let lineWidth: CGFloat
    let lineCap: CGLineCap
    
    @ViewBuilder let insideContent: () -> InsideContent
    
    private var adjustedProgress: CGFloat {
        CGFloat(max(0, min(1, progress)))
    }
    
    // MARK: Init
    init(
        progress: Binding<Double>,
        strokeStyle: LinearGradient = defaultStrokeStyle,
        lineWidth: CGFloat = defaultLineWidth,
        lineCap: CGLineCap = defaultLineCap,
        @ViewBuilder _ insideContent: @escaping () -> InsideContent
    ) {
        self._progress = progress
        self.strokeStyle = AnyShapeStyle(strokeStyle)
        self.lineWidth = lineWidth
        self.lineCap = lineCap
        self.insideContent = insideContent
    }
    
    init(
        progress: Binding<Double>,
        strokeStyle: AnyShapeStyle,
        lineWidth: CGFloat = defaultLineWidth,
        lineCap: CGLineCap = defaultLineCap,
        @ViewBuilder _ insideContent: @escaping () -> InsideContent
    ) {
        self._progress = progress
        self.strokeStyle = strokeStyle
        self.lineWidth = lineWidth
        self.lineCap = lineCap
        self.insideContent = insideContent
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
            
            insideContent()
        }
        .padding()
    }
}

extension CircularProgressView where InsideContent == EmptyView {
    init(
        progress: Binding<Double>,
        strokeStyle: LinearGradient = defaultStrokeStyle,
        lineWidth: CGFloat = defaultLineWidth,
        lineCap: CGLineCap = defaultLineCap
    ) {
        self._progress = progress
        self.strokeStyle = AnyShapeStyle(strokeStyle)
        self.lineWidth = lineWidth
        self.lineCap = lineCap
        self.insideContent = { EmptyView() }
    }
    
    init(
        progress: Binding<Double>,
        strokeStyle: AnyShapeStyle,
        lineWidth: CGFloat = defaultLineWidth,
        lineCap: CGLineCap = defaultLineCap
    ) {
        self._progress = progress
        self.strokeStyle = strokeStyle
        self.lineWidth = lineWidth
        self.lineCap = lineCap
        self.insideContent = { EmptyView() }
    }
}

struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressView(progress: .constant(0.2))
    }
}
