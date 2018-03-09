//
//  ReminderCellDelegate.swift
//  PillApp
//
//  Created by Eduardo Fornari on 08/03/18.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import Foundation

protocol ReminderCellDelegate {
    func setVisibilityPicker(with hide: Bool)
    func setReminderTime(with time: Date)
}
