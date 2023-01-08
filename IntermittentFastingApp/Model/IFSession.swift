//
//  IFSession.swift
//  IntermittentFastingApp
//
//  Created by Romero Peces Barba, Kevin on 8/1/23.
//

import Foundation

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
}

enum IFSessionKind: Codable {
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
}
