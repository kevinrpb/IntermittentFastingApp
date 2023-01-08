//
//  IntermittentFastingAppApp.swift
//  IntermittentFastingApp
//
//  Created by Romero Peces Barba, Kevin on 8/1/23.
//

import SwiftUI

@main
struct IntermittentFastingAppApp: App {
    @StateObject private var viewModel: AppViewModel = .default
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                BackgroundLayerView()
                ProgressLayerView()
                UILayerView()
            }
            .environmentObject(viewModel)
            .bottomPopover(isPresented: $viewModel.showOptionsPopover) {
                Text("hi")
            }
        }
    }
}
