//
//  AppViewModel.swift
//  IntermittentFastingApp
//
//  Created by Romero Peces Barba, Kevin on 8/1/23.
//

import SwiftUI

class AppViewModel: ObservableObject {
    // MARK: UI control
    @Published var showOptionsPopover: Bool = false
    
    // MARK: Session control
    @Published var currentSession: IFSession?
    @Published var progress: Double = 0.0
    
    // MARK: UI actions
    func startButtonAction() {
        withAnimation {
            currentSession = .init(start: .now, kind: .debug10Seconds)
        }
    }
    
    func optionsButtonAction() {
        showOptionsPopover = true
    }
    
    func historyButtonAction() {
        
    }
    
    // MARK: Internal
    var updateProgressTimer: Timer?

    private func startUpdatingProgress() {
        updateProgressTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: updateProgress)
    }

    private func stopUdatingProgress() {
        updateProgressTimer?.invalidate()
    }

    @MainActor
    private func updateProgress(_ timer: Timer) {
        guard let currentSession, currentSession.kind != .noGoal else { return }

        let ellapsed = Date.now.timeIntervalSince(currentSession.start)
        let goal = currentSession.timeInterval

        if ellapsed < goal {
            progress = ellapsed / goal
        } else {
            progress = 1
            stopUdatingProgress()
        }
    }
    
    // MARK: Singleton
    private init() {
        startUpdatingProgress()
    }
    public static let `default`: AppViewModel = .init()
}
