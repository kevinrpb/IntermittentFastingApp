//
//  BottomPopover.swift
//  IntermittentFastingApp
//
//  Created by Romero Peces Barba, Kevin on 8/1/23.
//

import SwiftUI

struct BottomPopover<Content: View>: View {
    @ViewBuilder
    let content: () -> Content
    
    var body: some View {
        HStack(spacing: 12) {
            Spacer()
            VStack {
                content()
            }
            Spacer()
        }
        .padding(EdgeInsets(top: 37, leading: 24, bottom: 40, trailing: 24))
        .background(Color.white.cornerRadius(20))
        .shadowedStyle()
    }
}

extension View {
    func bottomPopover<Content: View>(isPresented: Binding<Bool>, @ViewBuilder _ content: @escaping () -> Content) -> some View {
        self.popup(
            isPresented: isPresented,
            type: .floater(verticalPadding: 0, useSafeAreaInset: false),
            position: .bottom,
            closeOnTapOutside: true,
            backgroundColor: .secondary
        ) {
            BottomPopover(content: content)
        }
    }
}

//struct BottomPopover_Previews: PreviewProvider {
//    static var previews: some View {
//        BottomPopover()
//    }
//}
