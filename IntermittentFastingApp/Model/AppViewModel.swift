//
//  AppViewModel.swift
//  IntermittentFastingApp
//
//  Created by Romero Peces Barba, Kevin on 8/1/23.
//

import Combine
import SwiftUI

class AppViewModel: ObservableObject {
    // MARK: UI control
    @Published var showOptionsPopover: Bool = false
    
    // Options
    @Published var optionsSessionKind: IFSession.Kind = .daily16_8
    
    // MARK: Session control
    @Published var currentSession: IFSession?
    @Published var progress: Double = 0
    @Published var remaining: TimeInterval = -1
    
    @Published var remainingFormatted: String = ""
    
    func updateSession(start: Date? = nil, kind: IFSession.Kind? = nil) {
        withAnimation {
            currentSession = currentSession?.update(start: start, kind: kind)
        }
    }
    
    // MARK: UI actions
    func startButtonAction() {
        withAnimation {
            stopUdatingProgress()
            startUpdatingProgress()
            // NOTE: Add 1 second here to account for timer settings
            currentSession = .init(start: .now + 1, kind: optionsSessionKind)
        }
    }
    
    func optionsButtonAction() {
        showOptionsPopover = true
    }
    
    func optionsDoneButtonAction() {
        showOptionsPopover = false
    }
    
    func historyButtonAction() {
        
    }
    
    // MARK: Internal
    private lazy var dateFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        
        formatter.unitsStyle = .abbreviated
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.day, .hour, .minute, .second]
        
        return formatter
    }()
    
    var updateProgressTimer: Timer?

    private func startUpdatingProgress() {
        updateProgressTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: updateProgress)

        if currentSession?.kind.isDaily == true {
            dateFormatter.allowedUnits = [.hour, .minute, .second]
        } else if currentSession?.kind.isWeekly == true {
            dateFormatter.allowedUnits = [.day, .hour, .minute, .second]
        } else if currentSession?.kind.isDebug == true {
            dateFormatter.allowedUnits = [.hour, .minute, .second]
        }
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
        
        remainingFormatted = dateFormatter.string(from: remaining) ?? ""
    }
    
    // MARK: Singleton
    private var cancellables: [AnyCancellable] = []
    private init() {
        $optionsSessionKind
            .dropFirst()
            .sink { [weak self] kind in
                self?.stopUdatingProgress()
                self?.updateSession(kind: kind)
                self?.startUpdatingProgress()
            }
            .store(in: &cancellables)
    }
    public static let `default`: AppViewModel = .init()
}
