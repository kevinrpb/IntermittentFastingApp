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
    @Published var progress: Double = 0
    @Published var remaining: TimeInterval = -1
    
    @Published var remainingFormatted: String = ""
    
    // MARK: UI actions
    func startButtonAction() {
        withAnimation {
            startUpdatingProgress()
            // NOTE: Add 1 second here to account for timer settings
            currentSession = .init(start: .now + 1, kind: .debug10Seconds)
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
            // NOTE: Add 1 second here to account for timer settings
            remaining = goal - ellapsed + 1
        } else {
            progress = 1
            remaining = 0
            stopUdatingProgress()
        }
        
        remainingFormatted = RelativeDateTimeFormatter().localizedString(fromTimeInterval: remaining)
    }
    
    // MARK: Singleton
    private init() {}
    public static let `default`: AppViewModel = .init()
}
