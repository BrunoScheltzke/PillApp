//
//  CoreDataService.swift
//  PillApp
//
//  Created by Bruno Scheltzke on 03/10/18.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import UIKit
import CoreData

protocol LocalDatabaseServiceProtocol {
    func fetchAllReminders() -> [Reminder]
    @discardableResult func createReminder(medicine: Medicine, date: Date, dosage: Dosage, frequency: Frequency, quantity: Int32) -> Reminder
    @discardableResult func createMedicine(name: String, brand: String?, unit: Int32, dosage: Dosage) -> Medicine
}

class CoreDataService: LocalDatabaseServiceProtocol {
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var container: NSPersistentContainer! = nil
    
    init() {
        container = appDelegate.persistentContainer
    }
    
    func fetchAllReminders() -> [Reminder] {
        let request = NSFetchRequest<Reminder>(entityName: Keys.Reminder.tableName)
        var reminders: [Reminder] = []
        
        do {
            reminders = try container.viewContext.fetch(request)
        } catch  {
            print(error)
        }
        
        return reminders
    }
    
    @discardableResult func createReminder(medicine: Medicine, date: Date, dosage: Dosage, frequency: Frequency = .currentDayOnly, quantity: Int32) -> Reminder {
        let reminderObj = NSEntityDescription.insertNewObject(forEntityName: Keys.Reminder.tableName, into: container.viewContext) as! Reminder
        
        reminderObj.date = date
        reminderObj.dosage = dosage.rawValue
        reminderObj.frequency = Int32(frequency.rawValue)
        reminderObj.quantity = quantity
        reminderObj.medicine = medicine
        
        do {
            try container.viewContext.save()
        } catch {
            print(error)
        }
        
        NotificationManager.shared.setUpReminder(reminder: reminderObj)
        
        return reminderObj
    }
    
    @discardableResult func createMedicine(name: String, brand: String?, unit: Int32, dosage: Dosage) -> Medicine {
        let medicine = NSEntityDescription.insertNewObject(forEntityName: Keys.Medicine.tableName,
                                                           into: container.viewContext) as! Medicine
        medicine.name = name
        medicine.brand = brand
        medicine.unit = unit
        medicine.dosage = dosage.rawValue
        
        do {
            try container.viewContext.save()
        } catch {
            print(error)
        }
        
        return medicine
    }
}
