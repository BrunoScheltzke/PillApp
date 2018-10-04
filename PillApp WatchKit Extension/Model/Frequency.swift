//
//  Frequency.swift
//  PillApp WatchKit Extension
//
//  Created by Bruno Scheltzke on 07/03/18.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import Foundation

enum Frequency: Int, CaseIterable {
    case currentDayOnly = 0
    case everyDay
    case everySunday
    case everyMonday
    case everyTuesday
    case everyWednesday
    case everyThursday
    case everyFriday
    case everySaturday
    
    func asString() -> String {
        switch self {
        case .currentDayOnly: return "Current day only"
        case .everyDay: return "Everyday"
        case .everyMonday: return "Every monday"
        case .everyTuesday: return "Every tuesday"
        case .everyWednesday: return "Every wednesday"
        case .everyThursday: return "Every thursday"
        case .everyFriday: return "Every friday"
        case .everySaturday: return "Every saturday"
        case .everySunday: return "Every sunday"
        }
    }
}
