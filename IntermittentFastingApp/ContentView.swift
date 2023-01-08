//
//  ContentView.swift
//  IntermittentFastingApp
//
//  Created by Romero Peces Barba, Kevin on 8/1/23.
//

import SwiftUI

struct ProgressLayerView: View {
    @State var progress: Double = 1.0
    
    var body: some View {
        VStack {
            Spacer()
            CircularProgressView(progress: $progress)
                .frame(maxWidth: 300)
                .onTapGesture {
                    progress = Double.random(in: 0...1)
                }
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

struct ContentView: View {
    var body: some View {
        ZStack {
            BackgroundLayerView()
            ProgressLayerView()
            UILayerView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
