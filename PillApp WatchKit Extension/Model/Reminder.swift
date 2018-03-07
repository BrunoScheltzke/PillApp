//
//  Reminder.swift
//  PillApp WatchKit Extension
//
//  Created by Bruno Scheltzke on 07/03/18.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import Foundation

struct Reminder {
    var id: Int
    var medicine: Medicine
    var dosage: Dosage
    var quantity: Int
    var date: Date
    var frequency: Frequency
}
