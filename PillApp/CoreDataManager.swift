//
//  CoreDataManager.swift
//  PillApp
//
//  Created by Bruno Scheltzke on 07/03/18.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var container: NSPersistentContainer! = nil
    
    static let shared = CoreDataManager()
    
    func setup() {
        container = appDelegate.persistentContainer
    }
    
    @discardableResult func createMedicine(name: String, brand: String?, unit: Int32, dosage: Dosage) -> Medicine {
        let medicine = NSEntityDescription.insertNewObject(forEntityName: "Medicine",
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
    
    @discardableResult func createReminder(date: Date, dosage: Dosage, frequency: Frequency = .currentDayOnly, quantity: Int32, medicine: Medicine) -> Reminder {
        let reminderObj = NSEntityDescription.insertNewObject(forEntityName: "Reminder", into: container.viewContext) as! Reminder
        
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
        
        return reminderObj
    }
    
    @discardableResult func createRegister(date: Date, reminder: Reminder, taken: Bool) -> Register {
        let registerObj = NSEntityDescription.insertNewObject(forEntityName: "Register", into: container.viewContext) as! Register
        
        registerObj.date = date
        registerObj.reminder = reminder
        registerObj.taken = taken
        
        do {
            try container.viewContext.save()
        } catch {
            print(error)
        }
        
        return registerObj
    }
    
    func fetchAllReminders() -> [Reminder]? {
        let request = NSFetchRequest<Reminder>(entityName: "Reminder")
        var reminders: [Reminder]?
        
        do {
            reminders = try container.viewContext.fetch(request)
        } catch  {
            print(error)
        }
        
        return reminders
    }
    
    func fetchAllMedicines() -> [Medicine]? {
        let request = NSFetchRequest<Medicine>(entityName: "Medicine")
        var medicines: [Medicine]?
        
        do {
            medicines = try container.viewContext.fetch(request)
        } catch  {
            print(error)
        }
        
        return medicines
    }
    
    func fetchAllRegisters() -> [Register]? {
        let request = NSFetchRequest<Register>(entityName: "Register")
        var registers: [Register]?
        
        do {
            registers = try container.viewContext.fetch(request)
        } catch  {
            print(error)
        }
        
        return registers
    }
    
    func fetchReminder(by reminderId: URL) -> Reminder? {
        guard let reminderObjId = container.viewContext.persistentStoreCoordinator?.managedObjectID(forURIRepresentation: reminderId) else {
            return nil
        }
        
        return container.viewContext.object(with: reminderObjId) as? Reminder
    }
}
