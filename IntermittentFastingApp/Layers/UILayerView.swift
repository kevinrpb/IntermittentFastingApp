//
//  UILayerView.swift
//  IntermittentFastingApp
//
//  Created by Romero Peces Barba, Kevin on 8/1/23.
//

import SwiftUI

struct UILayerView: View {
    var body: some View {
        VStack {
            TopBar()
            
            Spacer()
            
            BottomBar()
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
    
    private func TopBar() -> some View {
        HStack {
            Button {
                
            } label: {
                Label("Settings", systemImage: "gear")
                    .labelStyle(.iconOnly)
            }
            
            Spacer()
        }
        .font(.title2)
    }
    
    private func BottomBar() -> some View {
        HStack {
            Spacer()
            
            Button("Start") {}
                .buttonStyle(.borderedProminent)
            
            Spacer()
        }
    }
}

struct UILayerView_Previews: PreviewProvider {
    static var previews: some View {
        UILayerView()
    }
}
