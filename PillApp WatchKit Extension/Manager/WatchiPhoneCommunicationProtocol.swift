//
//  WatchiPhoneCommunicationProtocol.swift
//  PillApp WatchKit Extension
//
//  Created by Bruno Scheltzke on 08/03/18.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import Foundation

struct CommunicationProtocol {
    static let notification = "notification"
    static let dailyReminders = "dailyReminders"
    static let medicineLeft = "medicineLeft"
}

struct Keys {
    static let reminderId = "reminderId"
    static let date = "date"
    static let medicineTaken = "medicineTaken"
    static let communicationCommand = "command"
    static let reminders = "reminders"
    
    struct Reminder {
        static let id = "id"
        static let date = "date"
        static let dosage = "dosage"
        static let frequency = "frequency"
        static let quantity = "quantity"
        static let medicine = "medicine"
    }
    
    struct Register {
        static let id = "id"
        static let date = "date"
        static let taken = "taken"
        static let reminder = "reminder"
    }
    
    struct Medicine {
        static let id = "id"
        static let brand = "brand"
        static let dosage = "dosage"
        static let name = "name"
        static let unit = "unit"
    }
}
