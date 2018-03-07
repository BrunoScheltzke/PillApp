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
    
    func start() {
        container = appDelegate.persistentContainer
    }
    
    func saveMedicine(name: String, brand: String, unit: String, quantity: String) {
        let medicine = NSEntityDescription.insertNewObject(forEntityName: "Medicine",
                                                           into: container.viewContext) as! Medicine
        medicine.name = name
        medicine.unit = Int32(unit)!
        medicine.brand = brand
        
        try? container.viewContext.save()
    }
    
    func save(_ register: Register) {
        try? container.viewContext.save()
    }
    
    
}
