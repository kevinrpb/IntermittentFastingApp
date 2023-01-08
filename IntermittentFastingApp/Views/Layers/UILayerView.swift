//
//  UILayerView.swift
//  IntermittentFastingApp
//
//  Created by Romero Peces Barba, Kevin on 8/1/23.
//

import SwiftUI

struct UILayerView: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        VStack {
            Spacer()
            
            BottomBar()
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
    
    private func BottomBar() -> some View {
        ZStack {
            HStack {
                OptionsButton()
                Spacer()
                HistoryButton()
            }
            
            HStack {
                Button("Start", action: viewModel.startButtonAction)
                    .buttonStyle(.borderedProminent)
            }
        }
    }
    
    private func OptionsButton() -> some View {
        Button(action: viewModel.optionsButtonAction) {
            Label("Options", systemImage: "slider.horizontal.3")
                .labelStyle(.iconOnly)
        }
    }
    
    private func HistoryButton() -> some View {
        Button(action: viewModel.historyButtonAction) {
            Label("History", systemImage: "chart.bar.xaxis")
                .labelStyle(.iconOnly)
        }
    }
}

struct UILayerView_Previews: PreviewProvider {
    static var previews: some View {
        UILayerView()
            .environmentObject(AppViewModel.default)
    }
}
