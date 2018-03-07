//
//  InterfaceController.swift
//  PillApp WatchKit Extension
//
//  Created by Bruno Scheltzke on 06/03/18.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import WatchKit
import Foundation

class MedicineListController: WKInterfaceController {
    
    let medicines: [Medicine] = {
        var medicines: [Medicine] = []
        medicines.append(Medicine(id: 1, name: "Paracetamal", unit: 10, dosage: .pill, brand: nil))
        medicines.append(Medicine(id: 1, name: "Tylenol", unit: 10, dosage: .pill, brand: nil))
        return medicines
    }()
    
    @IBOutlet var medicineTable: WKInterfaceTable!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        medicineTable.setNumberOfRows(medicines.count, withRowType: "MedicineRow")
        
        for index in 0..<medicineTable.numberOfRows {
            guard let controller = medicineTable.rowController(at: index) as? MedicineRowController else { continue }
            
            controller.medicine = medicines[index]
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        print("tomei")
    }
    
}
