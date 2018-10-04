//
//  CreateReminderViewModel.swift
//  PillApp
//
//  Created by Bruno Scheltzke on 04/10/18.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import Foundation

class CreateReminderViewModel {
    private let delegate: CreateReminderViewModelProtocol
    let database: LocalDatabaseServiceProtocol
    
    init(delegate: CreateReminderViewModelProtocol, database: LocalDatabaseServiceProtocol) {
        self.delegate = delegate
        self.database = database
    }
    
    func leave() {
        delegate.didAskToDismiss()
    }
    
    func createReminder() {
        
    }
}

protocol CreateReminderViewModelProtocol {
    func didAskToDismiss()
}
