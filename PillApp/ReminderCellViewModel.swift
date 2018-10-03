//
//  MedicineCellViewModel.swift
//  PillApp
//
//  Created by Bruno Scheltzke on 03/10/18.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import Foundation

class ReminderCellViewModel {
    var date: Date
    
    init(reminder: Reminder) {
        date = reminder.date!
    }
}
