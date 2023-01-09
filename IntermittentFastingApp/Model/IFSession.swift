//
//  IFSession.swift
//  IntermittentFastingApp
//
//  Created by Romero Peces Barba, Kevin on 8/1/23.
//

import SwiftUI

struct IFSession: Codable {
    typealias Kind = IFSessionKind

    let start: Date
    let end: Date?
    let timeInterval: TimeInterval
    let kind: Kind

    init(start: Date, kind: Kind) {
        self.start = start
        self.timeInterval = kind.timeInterval
        self.end = start + self.timeInterval
        self.kind = kind
    }
    
    func update(start: Date? = nil, kind: Kind? = nil) -> IFSession {
        .init(start: start ?? self.start, kind: kind ?? self.kind)
    }
}

enum IFSessionKind: String, CaseIterable, Codable, Identifiable {
    case daily13_11
    case daily16_8
    case daily18_6
    case daily20_4

    case weekly24
    case weekly48
    case weekly72

    case noGoal
    
    case debug10Seconds
    case debug1Hour
    
    var id: String {
        self.rawValue
    }
    
    var title: LocalizedStringKey {
        switch self {
        case .daily13_11: return "13:11"
        case .daily16_8: return "16:8"
        case .daily18_6: return "18:6"
        case .daily20_4: return "20:4"
        case .weekly24: return "24h"
        case .weekly48: return "48h"
        case .weekly72: return "72h"
        case .noGoal: return "No Goal"
        case .debug10Seconds: return "10s"
        case .debug1Hour: return "1h"
        }
    }
    
    private var hourIntervalMultiplier: Double {
        switch self {
        case .daily13_11: return 13
        case .daily16_8: return 16
        case .daily18_6: return 18
        case .daily20_4: return 20
        case .weekly24: return 24
        case .weekly48: return 48
        case .weekly72: return 72
        case .noGoal: return 0

        case .debug10Seconds: return (1/360)
        case .debug1Hour: return 1
        }
    }
    var timeInterval: TimeInterval {
        return 3600 * hourIntervalMultiplier
    }
    
    var isDaily: Bool {
        switch self {
        case .daily13_11, .daily16_8, .daily18_6, .daily20_4: return true
        default: return false
        }
    }
    
    var isWeekly: Bool {
        switch self {
        case .weekly24, .weekly48, .weekly72: return true
        default: return false
        }
    }
    
    var isDebug: Bool {
        switch self {
        case .debug10Seconds, .debug1Hour: return true
        default: return false
        }
    }
    
    // MARK: Enumerators
    public static var allowedCases: [IFSessionKind] {
        Self.dailyCases + Self.weeklyCases + Self.otherCases + Self.debugCases
    }
    
    public static let dailyCases: [IFSessionKind] = [.daily13_11, .daily16_8, .daily18_6, .daily20_4]
    public static let weeklyCases: [IFSessionKind] = [.weekly24, .weekly48, .weekly72]
    public static let otherCases: [IFSessionKind] = [.noGoal]
    public static let debugCases: [IFSessionKind] = [.debug10Seconds, .debug1Hour]
}
