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
    
    func fetchTodaysReminders() -> [Reminder]? {
        let request = NSFetchRequest<Reminder>(entityName: "Reminder")
        
        // Get the current calendar with local time zone
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        
        // Get today's beginning & end
        let dateFrom = calendar.startOfDay(for: Date()) // eg. 2016-10-10 00:00:00
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute],from: dateFrom)
        components.day! += 1
        let dateTo = calendar.date(from: components)! // eg. 2016-10-11 00:00:00
        // Note: Times are printed in UTC. Depending on where you live it won't print 00:00:00 but it will work with UTC times which can be converted to local time
        
        // Set predicate as date being today's date
        let datePredicate = NSPredicate(format: "(%@ <= date) AND (date < %@)", argumentArray: [dateFrom, dateTo])
        request.predicate = datePredicate
        
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
    
    func createMockData() {
        let paracetamol = createMedicine(name: "Paracetamol", brand: "Agafarma", unit: 50, dosage: .pill)
        createReminder(date: Date(), dosage: .pill, frequency: .everyDay, quantity: 1, medicine: paracetamol)
    }
    
    func toDictionary(_ reminder: Reminder) -> [String: Any] {
        var dict: [String: Any] = [:]

        dict[Keys.Reminder.id] = reminder.objectID.uriRepresentation().absoluteString
        dict[Keys.Reminder.date] = reminder.date
        dict[Keys.Reminder.dosage] = reminder.dosage
        dict[Keys.Reminder.frequency] = Int(reminder.frequency)
        dict[Keys.Reminder.medicine] = self.toDictionary(reminder.medicine!)
        dict[Keys.Reminder.quantity] = Int(reminder.quantity)
        
        return dict
    }
    
    func toDictionary(_ register: Register) -> [String: Any] {
        var dict: [String: Any] = [:]
        
        dict[Keys.Register.id] = register.objectID.uriRepresentation().absoluteString
        dict[Keys.Register.date] = register.date
        dict[Keys.Register.reminder] = toDictionary(register.reminder!)
        dict[Keys.Register.taken] = register.taken
        
        return dict
    }
    
    func toDictionary(_ medicine: Medicine) -> [String: Any] {
        var dict: [String: Any] = [:]
        
        dict[Keys.Medicine.id] = medicine.objectID.uriRepresentation().absoluteString
        dict[Keys.Medicine.brand] = medicine.brand
        dict[Keys.Medicine.dosage] = medicine.dosage
        dict[Keys.Medicine.name] = medicine.name
        dict[Keys.Medicine.unit] = Int(medicine.unit)
        
        return dict
    }
}
