//
//  Register.swift
//  PillApp WatchKit Extension
//
//  Created by Bruno Scheltzke on 09/03/18.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import Foundation

struct Register {
    var reminder: Reminder?
    var date: Date
    var taken: Bool
    
    init(_ dict: [String: Any]) {
        self.reminder = nil//dict[Keys.Register.reminder] as! Reminder
        self.date = dict[Keys.Register.date] as! Date
        self.taken = dict[Keys.Register.taken] as! Bool
    }
}
