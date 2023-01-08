//
//  ProgressLayerView.swift
//  IntermittentFastingApp
//
//  Created by Romero Peces Barba, Kevin on 8/1/23.
//

import SwiftUI

struct ProgressLayerView: View {
    @EnvironmentObject var viewModel: AppViewModel

    var body: some View {
        VStack {
            Spacer()
            if viewModel.currentSession != nil {
                CircularProgressView(progress: $viewModel.progress) {
                    RemainingTimeView()
                }
                .frame(maxWidth: 300)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder
    private func RemainingTimeView() -> some View {
        if viewModel.remaining > 0 {
            Text(viewModel.remainingFormatted)
        } else if viewModel.remaining < 0 {
            Text("")
        } else {
            Text("Done!")
        }
    }
}

struct ProgressLayerView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressLayerView()
            .environmentObject(AppViewModel.default)
    }
}
