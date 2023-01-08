//
//  BackgroundLayerView.swift
//  IntermittentFastingApp
//
//  Created by Romero Peces Barba, Kevin on 8/1/23.
//

import SwiftUI

struct BackgroundLayerView: View {
    var body: some View {
        VStack {
            Rectangle()
                .fill(.indigo.opacity(0.4))
        }
        .ignoresSafeArea()
    }
}

struct BackgroundLayerView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundLayerView()
    }
}
