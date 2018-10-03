//
//  RemindersViewModel.swift
//  PillApp
//
//  Created by Bruno Scheltzke on 03/10/18.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import Foundation

class RemindersViewModel {
    var reminderCellVMsByDate: [[ReminderCellViewModel]] = []
    
    private let database: LocalDatabaseServiceProtocol
    
    init(database: LocalDatabaseServiceProtocol) {
        self.database = database
        
        let reminders = database.fetchAllReminders()
        
        //group by date
        let temp = reminders.reduce(into: [Date: [ReminderCellViewModel]]()) {
            $0[$1.date!]?.append(ReminderCellViewModel(reminder: $1))
        }
        
        let sorted = Array(temp.keys).sorted(by: >)
        
        //separate into sections for tableView
        sorted.forEach { [unowned self] value in
            if let values = temp[value] {
                self.reminderCellVMsByDate.append(values)
            }
        }
    }
}

