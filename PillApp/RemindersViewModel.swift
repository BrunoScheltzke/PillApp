//
//  RemindersViewModel.swift
//  PillApp
//
//  Created by Bruno Scheltzke on 03/10/18.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import Foundation

class RemindersViewModel {
    // Outputs
    var reminderCellVMsByDate: [[ReminderCellViewModel]] = []
    let title: String
    
    private let database: LocalDatabaseServiceProtocol
    private let delegate: RemindersViewModelDelegate
    
    init(database: LocalDatabaseServiceProtocol, delegate: RemindersViewModelDelegate) {
        self.database = database
        self.delegate = delegate
        
        title = "Today"
        setupReminders()
    }
    
    private func setupReminders() {
        reminderCellVMsByDate = []
        let reminders = database.fetchAllReminders()
        
        //group by date
        var temp = [Date: [ReminderCellViewModel]]()
        let cal = Calendar(identifier: .gregorian)
        reminders.forEach { reminder in
            //check if it has key date if not create a different one
            guard let date = reminder.date else {return}
            let dateMid = cal.startOfDay(for: date)
            
            let reminderVM = ReminderCellViewModel(reminder: reminder)
            if temp.keys.contains(dateMid) {
                temp[dateMid]!.append(reminderVM)
            } else {
                temp[dateMid] = [reminderVM]
            }
        }
        
        let sorted = Array(temp.keys).sorted(by: >)
        
        //separate into sections for tableView
        sorted.forEach { [unowned self] value in
            if let values = temp[value] {
                self.reminderCellVMsByDate.append(values)
            }
        }
    }
    
    // Inputs
    func addReminder() {
        delegate.didAskToAddReminder()
    }
    
    func updateReminders() {
        setupReminders()
    }
}

protocol RemindersViewModelDelegate {
    func didAskToAddReminder()
}
