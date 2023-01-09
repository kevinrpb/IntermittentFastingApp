//
//  BottomPopover.swift
//  IntermittentFastingApp
//
//  Created by Romero Peces Barba, Kevin on 8/1/23.
//

import SwiftUI

import PopupView

struct BottomPopover<Content: View>: View {
    let backgroundColor: Color
    
    @ViewBuilder
    let content: () -> Content
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                content()
            }
            Spacer()
        }
        .background(backgroundColor)
        .background(Color.white.cornerRadius(20))
        .shadowedStyle()
    }
}

extension View {
    func bottomPopover<Content: View>(
        isPresented: Binding<Bool>,
        backgroundColor: Color = .white,
        content: @autoclosure @escaping () -> Content
    ) -> some View {
        self.popup(
            isPresented: isPresented,
            type: .floater(verticalPadding: 0, useSafeAreaInset: false),
            position: .bottom,
            closeOnTap: false,
            closeOnTapOutside: true,
            backgroundColor: .secondary
        ) {
            BottomPopover(backgroundColor: backgroundColor, content: content)
        }
    }
}

//struct BottomPopover_Previews: PreviewProvider {
//    static var previews: some View {
//        BottomPopover()
//    }
//}
